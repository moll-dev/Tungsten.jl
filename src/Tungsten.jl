module Tungsten

using ModernGL
using Observables
using Rocket
using GLFW

import GLMakie: GLAbstraction
const GLA = GLAbstraction
export GLA


include("events.jl")
export Event, WindowCloseEvent, WindowResizeEvent

include("window.jl")
export Window, OnUpdate

include("application.jl")
export Application



end # module
