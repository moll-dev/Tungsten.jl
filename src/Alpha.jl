module Alpha

using ModernGL

import GLMakie: GLAbstraction
const GLA = GLAbstraction
export GLA

greet() = print("Hello World!")

include("window.jl")
export Window, OnUpdate

end # module
