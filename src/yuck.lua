local ffi = require "ffi"
local engine = ffi.load "libyuck"

engine.printf("%s", "test\n")