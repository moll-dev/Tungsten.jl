using Tungsten

# TODO: Wrap this in an application class
window = Window(200, 300, "hello GL!")
running = true

while(running)
    glClearColor(1, 0, 1, 1)
    glClear(GL_COLOR_BUFFER_BIT)
    OnUpdate(window)
end
