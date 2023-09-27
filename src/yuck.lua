local ffi = require "ffi"
local engine = ffi.load "./libYuck.so"

ffi.cdef[[
    void puts(char*);
]]

function cs(s)
    return ffi.new("char[?]", #s+1, s)
end

engine.puts(cs"test");