"""
For now we'll just use the AsapScheduler for Rocket.jl
"""

abstract type Event end

struct WindowCloseEvent <: Event end

struct WindowResizeEvent <: Event
    width::Int
    height::Int
end

struct KeyEvent
    key::Keyboard.Button
    action::Keyboard.Action
end

struct MouseButtonEvent
    button::Mouse.Button
    action::Mouse.Action
end