mutable struct Window
    glWindow::GLFW.Window
    width::Int
    height::Int
    title::String
    vsync::Bool
    eventCallBack::Function
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
    GLFW.SetWindowSizeCallback(window, (window, width, height) -> begin
        window.eventCallBack(WindowResizeEvent(width, height))
    end)

    Window(window, width, height, title, true, () -> ())
end

function Shutdown(window::Window)
    @info "Shutting down window" 
    GLFW.DestroyWindow(window.glWindow)
end

function OnUpdate(window::Window)
    # do something with GLFW events
    GLFW.PollEvents()
    GLFW.SwapBuffers(window.glWindow)
end

function SetVSync(window::Window, enabled::Bool)
    enabled ? GLFW.SwapInterval(1) : GLFW.SwapInterval(0)
    window.vsync = enabled
end