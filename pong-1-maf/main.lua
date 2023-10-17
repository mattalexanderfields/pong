--my written version of pong-1 main

push = require 'pong-1.push' --get push.lua module

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

function love.load() --init function that is run once
    --sets the filter to nearest neighbor instead of linear 
    --(which would make it blurry instead of pixellated)
    love.graphics.setDefaultFilter("nearest", "nearest")
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

end

--handle esc keypress
function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
    
end

function love.draw()
    push:apply('start')

    love.graphics.printf('Hello Pong!',0,VIRTUAL_HEIGHT / 2 - 6,VIRTUAL_WIDTH,'center')
    
    push:apply('end')
end