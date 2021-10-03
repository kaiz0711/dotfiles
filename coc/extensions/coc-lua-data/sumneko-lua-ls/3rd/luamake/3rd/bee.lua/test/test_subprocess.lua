local lu = require 'ltest'

local subprocess = require 'bee.subprocess'
local thread = require 'bee.thread'
local platform = require 'bee.platform'
local shell = require 'shell'

local function getexe()
    local i = 0
    while arg[i] ~= nil do
        i = i - 1
    end
    return arg[i + 1]
end

local function createLua(script, option)
    local init = ("package.cpath = [[%s]]"):format(package.cpath)
    option = option or {}
    option[1] = {
        getexe(),
        '-e', init,
        '-e', script,
    }
    return subprocess.spawn(option)
end

local function createTestArgsFile(tbl)
    local s = {}
    for _, v in ipairs(tbl) do
        s[#s+1] = ('%q'):format(v)
    end
    local f = assert(io.open('test_temp.lua', 'wb'))
    f:write(([=[
        package.cpath = [[%s]]
        local function eq(a, b)
            assert(#a == #b)
            for i, v in ipairs(a) do
                assert(v == b[i], b[i])
            end
        end
        local t = {%s}
        eq(arg, t)
    ]=]):format(package.cpath, table.concat(s, ',')))
    f:close()
end

local function testArgs(...)
    local args = table.pack(...)
    createTestArgsFile(args)
    local option = {}
    option.stderr = true
    option[1] = getexe()
    option[2] = 'test_temp.lua'
    table.move(args, 1, args.n, 3, option)
    local process = subprocess.spawn(option)
    lu.assertIsUserdata(process)
    lu.assertIsUserdata(process.stderr)
    lu.assertEquals(process.stderr:read 'a', '')
    lu.assertEquals(process:wait(), 0)
    os.remove "test_temp.lua"
end

local test_subprocess = lu.test "subprocess"

function test_subprocess:test_spawn()
    lu.assertIsUserdata(createLua ' ')

    local process = createLua(' ', { stdin = true })
    lu.assertIsUserdata(process)
    lu.assertIsUserdata(process.stdin)
    lu.assertEquals(process.stdout, nil)
    lu.assertEquals(process.stderr, nil)

    local process = createLua(' ', { stdout = true })
    lu.assertIsUserdata(process)
    lu.assertEquals(process.stdin, nil)
    lu.assertIsUserdata(process.stdout)
    lu.assertEquals(process.stderr, nil)

    local process = createLua(' ', { stderr = true })
    lu.assertIsUserdata(process)
    lu.assertEquals(process.stdin, nil)
    lu.assertEquals(process.stdout, nil)
    lu.assertIsUserdata(process.stderr)
end

function test_subprocess:test_wait()
    local process = createLua ' '
    lu.assertEquals(process:wait(), 0)

    local process = createLua 'os.exit(true)'
    lu.assertEquals(process:wait(), 0)

    local process = createLua 'os.exit(false)'
    lu.assertEquals(process:wait(), 1)

    local process = createLua 'os.exit(197)'
    lu.assertEquals(process:wait(), 197)
end

function test_subprocess:test_is_running()
    local process = createLua('io.read "a"', { stdin = true })
    lu.assertEquals(process:is_running(), true)
    lu.assertIsUserdata(process.stdin)
    process.stdin:close()
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process:is_running(), false)
end

function test_subprocess:test_kill()
    local process = createLua('io.read "a"', { stdin = true })
    lu.assertEquals(process:is_running(), true)
    lu.assertEquals(process:kill(), true)
    lu.assertEquals(process:is_running(), false)
    lu.assertEquals(process:wait() & 0xFF, 0)

    local process = createLua('io.read "a"', { stdin = true })
    lu.assertEquals(process:is_running(), true)
    lu.assertEquals(process:kill(0), true)
    lu.assertEquals(process:is_running(), true)
    lu.assertIsUserdata(process.stdin)
    process.stdin:close()
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process:is_running(), false)
    lu.assertEquals(process:kill(0), false)
end

function test_subprocess:test_stdio_1()
    local process = createLua('io.stdout:write("ok")', { stdout = true })
    lu.assertEquals(process:wait(), 0)
    lu.assertIsUserdata(process.stdout)
    lu.assertEquals(process.stdout:read(2), "ok")
    lu.assertEquals(process.stdout:read(2), nil)

    local process = createLua('io.stderr:write("ok")', { stderr = true })
    lu.assertEquals(process:wait(), 0)
    lu.assertIsUserdata(process.stderr)
    lu.assertEquals(process.stderr:read(2), "ok")
    lu.assertEquals(process.stderr:read(2), nil)

    local process = createLua('io.write(io.read "a")', { stdin = true, stdout = true, stderr = true })
    lu.assertIsUserdata(process.stdin)
    lu.assertIsUserdata(process.stdout)
    lu.assertIsUserdata(process.stderr)
    lu.assertEquals(process:is_running(), true)
    process.stdin:write "ok"
    process.stdin:close()
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process.stdout:read(2), "ok")
    lu.assertEquals(process.stdout:read(2), nil)

    local process = createLua('error "Test subprocess error."', { stderr = true })
    lu.assertEquals(process:wait(), 1)
    local found = not not string.find(process.stderr:read "a", "Test subprocess error.", nil, true)
    lu.assertEquals(found, true)
end

function test_subprocess:test_stdio_2()
    os.remove 'temp.txt'
    local f = io.open('temp.txt', 'w')
    lu.assertIsUserdata(f)
    local process = createLua('io.write "ok"', { stdout = f })
    lu.assertEquals(process.stdout, f)
    f:close()
    lu.assertEquals(process:wait(), 0)
    local f = io.open('temp.txt', 'r')
    lu.assertIsUserdata(f)
    lu.assertEquals(f:read 'a', "ok")
    f:close()

    os.remove 'temp.txt'
    local wr = io.open('temp.txt', 'w')
    local rd = io.open('temp.txt', 'r')
    lu.assertIsUserdata(wr)
    lu.assertIsUserdata(rd)
    local process = createLua('io.write "ok"', { stdout = wr })
    wr:close()
    lu.assertEquals(process.stdout, wr)
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(rd:read 'a', "ok")
    rd:close()
    os.remove 'temp.txt'

    local process1 = createLua('io.write "ok"', { stdout = true })
    local process2 = createLua('io.write(io.read "a")', { stdin = process1.stdout, stdout = true })
    lu.assertEquals(process1:wait(), 0)
    lu.assertEquals(process2:wait(), 0)
    lu.assertEquals(process2.stdout:read 'a', "ok")
end

function test_subprocess:test_stdio_3()
    local process = createLua([[
        io.stdout:write "[stdout]"; io.stdout:flush()
        io.stderr:write "[stderr]"; io.stderr:flush()
    ]], { stdout = true, stderr = "stdout" })
    lu.assertEquals(process:wait(), 0)
    lu.assertIsUserdata(process.stdout)
    lu.assertIsUserdata(process.stderr)
    lu.assertEquals(process.stdout, process.stderr)
    lu.assertEquals(process.stdout:read "a", "[stdout][stderr]")
end

function test_subprocess:test_peek()
    local process = createLua('io.write "ok"', { stdout = true })
    lu.assertEquals(process:wait(), 0)
    lu.assertIsUserdata(process.stdout)
    lu.assertEquals(subprocess.peek(process.stdout), 2)
    lu.assertEquals(subprocess.peek(process.stdout), 2)
    lu.assertEquals(process.stdout:read(2), "ok")
    lu.assertEquals(subprocess.peek(process.stdout), nil)

    local process = createLua('io.write "ok"', { stdout = true })
    lu.assertEquals(process:wait(), 0)
    lu.assertIsUserdata(process.stdout)
    lu.assertEquals(subprocess.peek(process.stdout), 2)
    process.stdout:close()
    lu.assertError("attempt to use a closed file", process.stdout.read, process.stdout, 2)
    lu.assertEquals(subprocess.peek(process.stdout), nil)

    local process = createLua('io.stdout:setvbuf "no" io.write "start" io.write(io.read "a")', { stdin = true, stdout = true })
    lu.assertIsUserdata(process.stdin)
    lu.assertIsUserdata(process.stdout)
    lu.assertEquals(process:is_running(), true)
    while true do
        local n = subprocess.peek(process.stdout)
        if n >= 5 then
            process.stdout:read(5)
            break
        end
        thread.sleep(0)
    end
    process.stdin:write "ok"
    process.stdin:close()
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process.stdout:read(2), "ok")
    lu.assertEquals(process.stdout:read(2), nil)
end

function test_subprocess:test_filemode()
    if platform.OS == 'Windows' then
        local process = createLua([[
            assert(io.read "a" == "\n")
        ]], { stdin = true, stderr = true })
        process.stdin:write "\r\n"
        process.stdin:close()
        lu.assertEquals(process:wait(), 0)
        lu.assertEquals(process.stderr:read "a", "")
    end
    local process = createLua([[
        local sp = require "bee.subprocess"
        sp.filemode(io.stdin, 'b')
        assert(io.read "a" == "\r\n")
    ]], { stdin = true, stderr = true })
    process.stdin:write "\r\n"
    process.stdin:close()
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process.stderr:read "a", "")
end

function test_subprocess:test_env()
    local function test_env(cond, env)
        local script = ('assert(%s)'):format(cond)
        lu.assertEquals(
            createLua(
                script,
                {env = env}
            ):wait(),
            0
        )
    end
    test_env('os.getenv "BEE_TEST" == nil', {})
    test_env('os.getenv "BEE_TEST" == "ok"', { BEE_TEST = 'ok' })

    subprocess.setenv("BEE_TEST_ENV_1", "OK")
    lu.assertEquals(os.getenv 'BEE_TEST_ENV_1', "OK")
    test_env('os.getenv "BEE_TEST_ENV_1" == "OK"', {})
    test_env('os.getenv "BEE_TEST_ENV_1" == nil', {BEE_TEST_ENV_1=false})
end

function test_subprocess:test_args()
    testArgs('A')
    testArgs('A', 'B')
    testArgs('A B')
    testArgs('A', 'B C')
    testArgs([["A"]])
    testArgs([["A]])
    testArgs([["A\]])
    testArgs([["A\"]])
    testArgs([[A" B]])
end

function test_subprocess:test_setenv()
    lu.assertEquals(os.getenv "TEST_ENV", nil)
    local process = createLua([[
        assert(os.getenv "TEST_ENV" == nil)
    ]], { stderr = true })
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process.stderr:read "a", "")

    subprocess.setenv("TEST_ENV", "OK")

    lu.assertEquals(os.getenv "TEST_ENV", "OK")
    local process = createLua([[
        assert(os.getenv "TEST_ENV" == "OK")
    ]], { stderr = true })
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process.stderr:read "a", "")
end

function test_subprocess:test_encoding()
    local process = createLua([[
        print "中文"
    ]], { stdout = true })
    lu.assertEquals(process:wait(), 0)
    lu.assertEquals(process.stdout:read(6), "中文")
end
