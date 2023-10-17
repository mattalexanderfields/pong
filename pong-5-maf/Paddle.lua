Paddle = Class{}

function Paddle:init(x,y,width,height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
end

function Paddle:update(dt)
    --this is cool, if delta y is negative that means paddle is going up,
    --so use max 0 to limit paddle to visual space,
    --otherwise use min height minus size of paddle because we know it is moving
    --down if dy is positive
    if self.dy < 0 then
        self.y = math.max(0, self.y + self.dy * dt)
    else
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + self.dy * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end