using Tungsten


application = Application("new world!")

@info "Running Application! $(application.window.title)"

push!(application.layers, DebugLayer("layer_0"))
Run(application)

