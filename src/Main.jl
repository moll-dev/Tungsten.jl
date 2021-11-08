using Tungsten


application = Application("new world!")

@info "Running Application! $(application.window.title)"
Run(application)

