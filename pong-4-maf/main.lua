push = require 'pong-1.push'

WINDOW_HEIGHT = 720
WINDOW_WIDTH = 1280
VIRTUAL_HEIGHT = 243
VIRTUAL_WIDTH = 432

PADDLE_SPEED = 200

function love.load()
    --retro filter with nearest-neighbor filtering
    love.graphics.setDefaultFilter("nearest", "nearest")

    --sets a seed for random using current time as that will always be different when running
    math.randomseed(os.time())

    --sets default font as the font file in folder and 8pt
    smallFont = love.graphics.getFont('font.ttf', 8)
    love.graphics.setFont(smallFont)

    --screen info
    push:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    --starting position of player paddles
    player1Y = 30
    player2Y = VIRTUAL_HEIGHT - 50

    --starting position of ball
    ballX = VIRTUAL_WIDTH / 2 - 2
    ballY = VIRTUAL_HEIGHT / 2 - 2

    --random velocity for ball
    ballDX = math.random(2) == 1 and 100 or -100
    ballDY = math.random(-50,50)

    --setting different game states will allow for menus/titles/etc
    gameState = 'start'
    
end

function love.update(dt)
    if love.keyboard.isDown('w') then
        player1Y = math.max(0, player1Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('s') then
        player1Y = math.min(VIRTUAL_HEIGHT - 20, player1Y + PADDLE_SPEED * dt)
    end
    
    if love.keyboard.isDown('up') then
        player2Y = math.max(0, player2Y + -PADDLE_SPEED * dt)
    elseif love.keyboard.isDown('down') then
        player2Y = math.min(VIRTUAL_HEIGHT - 20, player2Y + PADDLE_SPEED * dt)
    end

    if gameState == 'play' then
        ballX = ballX + ballDX * dt
        ballY = ballY + ballDY * dt
    end

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            ballX = VIRTUAL_WIDTH / 2 - 2
            ballY = VIRTUAL_HEIGHT / 2 - 2
            ballDX = math.random(2) == 1 and 100 or -100
            ballDY = math.random(-50,50) * 1.5
        end
    end
    
end

function love.draw()
    push:apply('start')

    love.graphics.clear(40/255,45/255,52/255, 255/255)
    love.graphics.setFont(smallFont)

    if gameState == 'start' then
        love.graphics.printf('Hello Start State!',0,20,VIRTUAL_WIDTH,'center')
    else
        love.graphics.printf('Hello Play State!',0,20,VIRTUAL_WIDTH, "center")
    end

    love.graphics.rectangle('fill',10,player1Y,5,20)
    love.graphics.rectangle('fill',VIRTUAL_WIDTH - 10,player2Y,5,20)

    love.graphics.rectangle('fill',ballX,ballY,4,4)

    push:apply('end')
end
