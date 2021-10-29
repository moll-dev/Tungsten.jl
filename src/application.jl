# Maybe this is overkill for now
mutable struct Application
    window::Window
    events::Dict{Symbol, Subject}
end

# TODO: Accept command line args / etc here
function Application(title)
    window = Window(800, 600, title)

    
    events = Dict{Symbol, Subject}

    # Maybe not the best place to setup listeners? TODO: Use Actors
    push!(events, :WindowResizeEvent, Subject(WindowResizeEvent))
    subscribe!(events[:WindowResizeEvent], logger())

    application =  Application(window, events)

    # Subscribe == callback
    window.eventCallBack = event -> OnEvent(application, event)
    return application
end

function OnEvent(app::Application, e::Event)
    # Dispatch!
    println(e)
end