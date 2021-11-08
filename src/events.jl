"""
For now we'll just use the AsapScheduler for Rocket.jl
"""

abstract type Event end

struct WindowCloseEvent <: Event
    should_close::Bool
end

struct WindowResizeEvent <: Event
    width::Int
    height::Int
end

