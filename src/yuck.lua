local ffi = require "ffi"
local engine = ffi.load "./libyuck.so"
local yuck = {}

-- the got dam GLFW3
ffi.cdef[[
    void puts(char*);
    struct GLFWwindow* glfwCreateWindow(unsigned int width, unsigned int height, char *title, struct GLFWmonitor *monitor, struct GLFWwindow *share);
    void glfwWindowHint(int hint, int value);
    int glfwWindowShouldClose(struct GLFWwindow* window);
    void glfwPollEvents();
    void glfwTerminate();
    void glfwInit();
    void glfwDestroyWindow(struct GLFWwindow* window);
    
    enum {
        GLFW_FALSE = 0,
        GLFW_TRUE = 1,

        GLFW_CLIENT_API             = 0x00022001,
        GLFW_NO_API                 = 0x0,

        GLFW_CONTEXT_VERSION_MAJOR  = 0x00022002,
        GLFW_CONTEXT_VERSION_MINOR  = 0x00022003,
        GLFW_RESIZABLE              = 0x00020003,
    };
]]



function cstr(s)
    return ffi.new("char[?]", #s+1, s)
end

function ls(cstr)
    return ffi.string(cstr)
end

function cbool(cbool)
    return cbool == 1
end

yuck.log = print

print'0'
engine.glfwInit();
print'1'
engine.glfwWindowHint(engine.GLFW_CLIENT_API, engine.GLFW_NO_API);
print'2'
engine.glfwWindowHint(engine.GLFW_RESIZABLE, engine.GLFW_FALSE);
print'3'
local window = engine.glfwCreateWindow(800, 600, cstr"Test", nil, nil);
print'4'

while cbool(engine.glfwWindowShouldClose(window)) == false do
    engine.glfwPollEvents();
end

print("Terminating window");
engine.glfwTerminate();
print'5'

-- return yuck