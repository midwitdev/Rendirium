local ffi = require "ffi"
local engine = ffi.load "./libYuck.so"
local yuck = {}

-- the got dam GLFW3
ffi.cdef[[
    void puts(char*);
    struct GLFWwindow glfwCreateWindow(int width, int height, const char *title, struct GLFWmonitor *monitor, struct GLFWwindow *share);
    void glfwWindowHint(int hint, int value);
    int glfwWindowShouldClose(struct GLFWwindow* window);
    void glfwPollEvents();
    void glfwTerminate();
    void glfwInit();
    void glfwDestroyWindow(struct GLFWwindow* window);
    
    enum {
        GLFW_FALSE,
        GLFW_TRUE,
    }
]]



function cs(s)
    return ffi.new("char[?]", #s+1, s)
end

function ls(cstr)
    return ffi.string(cstr)
end

yuck.log = print

engine.puts(cs(ls(cs"test")));

engine.glfwInit();
engine.glfwWindowHint(engine.GLFW_CLIENT_API, engine.GLFW_NO_API);
engine.glfwWindowHint(engine.GLFW_RESIZABLE, engine.GLFW_FALSE);
local window = engine.glfwCreateWindow(800, 600, "Test", nil, nil);
engine.glfwTerminate();

-- YAY!!!!!!!!!

-- return yuck