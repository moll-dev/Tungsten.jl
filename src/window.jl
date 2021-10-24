using GLFW
import Base.getproperty

struct Window
    glWindow::GLFW.Window
    width::Int
    height::Int
    title::String
    vsync::Bool
end

function Window(width::Int, height::Int, title::String)
    @info "Creating a window [$title]"
    window = try 
        GLFW.CreateWindow(width, height, title)
    catch e
        @warn "GLFW Window couldn't be created"
        rethrow(e)
    end

    GLFW.MakeContextCurrent(window)
    Window(window, width, height, title, true)
end

function Shutdown(window::Window)
    @info "Shutting down window" 
    GLFW.DestroyWindow(window.glWindow)
end

function OnUpdate(window::Window)
    GLFW.PollEvents()
    GLFW.SwapBuffers(window.glWindow)
end

function SetVSync(window::Window, enabled::Bool)
    enabled ? GLFW.SwapInterval(1) : GLFW.SwapInterval(0)
    window.vsync = enabled
end