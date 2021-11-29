import Base.iterate, Base.push!, Base.length, Base.pop!


abstract type AbstractLayer end

abstract type Layer <: AbstractLayer end
abstract type Overlay <: AbstractLayer end

struct DebugLayer <: Layer
    layer_name::String
end

struct DebugOverlay <: Overlay
    layer_name::String
end

function OnUpdate(layer::DebugLayer)
    @info "Layer $(layer.layer_name) being updated!"
end

function OnEvent(layer::DebugLayer, event::Event)
    @info "Logging event for $(layer.layer_name)"
end

"""
    Events scan top down.
    Rendered Bottom up.
"""
mutable struct LayerStack
    layers::Vector{Layer}
    overlays::Vector{Overlay}
    LayerStack() = new(Vector{Layer}(), Vector{Overlay}())
end

Base.push!(lstack::LayerStack, layer::Layer) = push!(lstack.layers, layer)
Base.push!(lstack::LayerStack, overlay::Overlay) = push!(lstack.overlays, overlay)

function Base.pop!(lstack::LayerStack, layer::T) where {T <: Layer}
    indexes = findall(isequal(layer), lstack.layers)
    p_layer = nothing
    if length(indexes) > 0
        p_layer = popat!(lstack.layers, indexes[1])
    end

    lstack.layers = filter(!isequal(layer), lstack.layers)
    return p_layer
end

function Base.pop!(lstack::LayerStack, overlay::Overlay)
    indexes = findall(isequal(overlay), lstack.overlays)
    p_overlay = nothing
    if length(indexes) > 0
        p_overlay = popat!(lstack.overlays, indexes[1])
    end

    lstack.overlays = filter(!isequal(overlay), lstack.overlays)
    return p_overlay
end

function popOverlay!(lstack::LayerStack)
    return pop!(lstack.overlays)
end


Base.length(lstack::LayerStack) = length(lstack.layers)

function Base.iterate(ls::LayerStack, state = 1)
    if state > (length(ls.layers) + length(ls.overlays))
        return nothing
    end

    if state > length(ls.layers)
        return ls.overlays[state - length(ls.layers)], state + 1
    else
        return ls.layers[state], state + 1
    end
end