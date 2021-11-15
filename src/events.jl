"""
Currently, just using callbacks, not Rocket.jl
"""

abstract type Event end

struct WindowCloseEvent <: Event end

struct WindowResizeEvent <: Event
    width::Int
    height::Int
end

struct KeyEvent <: Event
    key::Keyboard.Button
    action::Keyboard.Action
end

struct MouseButtonEvent <: Event
    button::Mouse.Button
    action::Mouse.Action
end
