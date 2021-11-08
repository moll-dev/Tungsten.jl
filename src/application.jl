# Maybe this is overkill for now
mutable struct Application
    window::Window
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
    application = Application(window, events)
    registerGLFWCallbacks(application, window)
    return application
end

function registerGLFWCallbacks(application::Application, window::Window)
    GLFW.SetWindowSizeCallback(window.glWindow, (window, width, height) -> begin
        OnEvent(application, WindowResizeEvent(width, height))
    end)
end
# Entry point!
# TODO: Catch crtl-c interrupts
function Run(application::Application)
    while true
        OnUpdate(application.window)
    end
end

OnEvent(app::Application, e::T) where {T <: Event} = @warn "No dispatchable functions!"
