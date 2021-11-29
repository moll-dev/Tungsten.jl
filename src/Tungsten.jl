module Tungsten

using ModernGL
using Observables
using Rocket
using GLFW

import GLMakie: GLAbstraction
const GLA = GLAbstraction
export GLA

include("input.jl")
export Keyboard, Mouse

include("events.jl")
export Event, WindowCloseEvent, WindowResizeEvent

include("layer.jl")
export Layer, Overlay, DebugLayer, DebugOverlay, LayerStack

include("window.jl")
export Window, OnUpdate

include("application.jl")
export Application, OnEvent, Run



end # module
