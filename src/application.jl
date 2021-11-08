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

function registerGLFWCallbacks(application::Application, window::Window)
    glWindow = window.glWindow
    GLFW.SetWindowSizeCallback(glWindow, (window, width, height) -> begin
        OnEvent(application, WindowResizeEvent(width, height))
    end)

    GLFW.SetWindowCloseCallback(glWindow, (window) -> begin
        OnEvent(application, WindowCloseEvent())
    end)

    function keyboardbuttons(window, button, scancode::Cint, action, mods::Cint)
        OnEvent(application, KeyEvent(Keyboard.Button(Int(button)), Keyboard.Action(Int(action))))
    end
    GLFW.SetKeyCallback(glWindow, keyboardbuttons)
end
# Entry point!
# TODO: Catch crtl-c interrupts
function Run(application::Application)
    while application.is_running
        OnUpdate(application.window)
    end
end

OnEvent(app::Application, e::Event) = @warn "No dispatchable functions for $(typeof(e))!\n$(display(e))"

# TODO: Super quick and dirty :(
function OnEvent(app::Application, e::WindowCloseEvent)
    # TODO: Remap this function call to be something more julian?
    GLFW.DestroyWindow(app.window.glWindow)
    app.is_running = false
end