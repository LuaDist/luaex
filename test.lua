-- rudimentary tests for luaex.
-- Submitted to luaex by LuaDist, D.Manura.

require 'ex'
assert(type(os.currentdir()) =='string')
os.sleep(0.1)
assert(type(os.dirent('.')) == 'table')
assert(type(os.environ()) == 'table')
os.setenv("_luaex_test", "123")
assert(os.getenv("_luaex_test") == "123")
assert(os.environ()._luaex_test == "123")
os.remove "_luaex_test"
assert(not os.dirent "_luaex_test")
os.mkdir "_luaex_test"
assert(os.dirent "_luaex_test")
print(os.dirent "_luaex_test".name)
for k,v in pairs(os.dirent "_luaex_test") do print('-',k,v) end
assert(os.dirent "_luaex_test".name == nil)
assert(os.dirent "_luaex_test".type == 'directory')
assert(type(os.dirent "_luaex_test".size) == 'number')
os.remove "_luaex_test"
assert(not os.dirent "_luaex_test")
local proc = os.spawn{'echo', '123'}
assert(proc:wait() == 0)
local proc = os.spawn{'program-that-does-not-exist-123', '123'}
assert(proc:wait() ~= 0)
local rd, wr = assert(io.pipe())
local proc = os.spawn{'echo', '123', stdout=wr}
wr:close()
assert(rd:read'*a':match'----')
proc:wait()


print 'OK'
