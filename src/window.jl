mutable struct Window
    glWindow::GLFW.Window
    width::Int
    height::Int
    title::String
    vsync::Bool
end

function Window(width::Int, height::Int, title::String)
    @info "Creating a window [$title : $width x $height]"
    window = try 
        GLFW.CreateWindow(width, height, title)
    catch e
        @warn "GLFW Window couldn't be created"
        rethrow(e)
    end

    GLFW.MakeContextCurrent(window)

    Window(window, width, height, title, true)
end

function destroy!(window::Window)
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