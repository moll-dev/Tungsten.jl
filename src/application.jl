# Maybe this is overkill for now


mutable struct Application
    window::Window
    is_running::Bool
    events::Dict{Symbol, <: Subject}
end

# TODO: Accept command line args / etc here
function Application(title)
    window = Window(800, 600, title)

    events = Dict{Symbol, Subject}()

    # Maybe not the best place to setup listeners? TODO: Use Actors
    push!(events, :WindowResizeEvent => Subject(WindowResizeEvent))
    subscribe!(events[:WindowResizeEvent], logger())

    # TODO: Kind of a weird circular reference here? Might need to fix it.
    application = Application(window, true, events)
    registerGLFWCallbacks(application, window)
    return application
end

# TODO: Probably should setup Rocket.jl here at some point.
function registerGLFWCallbacks(application::Application, window::Window)
    glWindow = window.glWindow

    windowresize(window, width, height) = OnEvent(application, WindowResizeEvent(width, height))
    GLFW.SetWindowSizeCallback(glWindow, windowresize)

    windowclose(window) = OnEvent(application, WindowCloseEvent())
    GLFW.SetWindowCloseCallback(glWindow, windowclose)

    keyboardbuttons(window, button, scancode::Cint, action, mods::Cint) = OnEvent(application, KeyEvent(Keyboard.Button(Int(button)), Keyboard.Action(Int(action))))
    GLFW.SetKeyCallback(glWindow, keyboardbuttons)

    mousebutton(window, button, action, mods) = OnEvent(application, MouseButtonEvent(Mouse.Button(Int(button)), Mouse.Action(Int(action))))
    GLFW.SetMouseButtonCallback(glWindow, mousebutton) 
end
# Entry point!
# TODO: Catch crtl-c interrupts
function Run(application::Application)
    try
        while application.is_running
            OnUpdate(application.window)
        end
    finally
        OnEvent(application, WindowCloseEvent())
    end
end

OnEvent(app::Application, e::Event) = @info "Function for $(typeof(e))!\n$(show(e))"

# TODO: Super quick and dirty :(
function OnEvent(app::Application, e::WindowCloseEvent)
    if app.is_running
        # TODO: Remap this function call to be something more julian?
        destroy!(app.window)
        app.is_running = false
    end
end