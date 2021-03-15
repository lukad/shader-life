local timer = require "lib.hump.timer"

local windowWidth
local windowHeight
local width
local height

local shader
local canvas
local data
local image

local scale = 4

local running = false

function love.load()
    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()

    width = math.floor(windowWidth / scale)
    height = math.floor(windowHeight / scale)

    canvas = love.graphics.newCanvas(width, height)

    shader = love.graphics.newShader("shader.glsl")
    shader:send("size", {width, height})

    data = love.image.newImageData(width, height)

    local x = 60
    local y = 50
    data:setPixel(x + 1, y, 255, 255, 255, 255)
    data:setPixel(x + 2, y, 255, 255, 255, 255)
    data:setPixel(x, y + 1, 255, 255, 255, 255)
    data:setPixel(x + 1, y + 1, 255, 255, 255, 255)
    data:setPixel(x + 1, y + 2, 255, 255, 255, 255)

    image = love.graphics.newImage(data)
    image:setFilter("linear", "nearest")

    timer.every(0.025, step)
end

function love.update(dt)
    if running then
        timer.update(dt)
    end
end

function love.keypressed(key, _scancode, _isrepeat)
    if key == "space" then
        running = not running
    end
end

function love.draw()
    love.graphics.clear()
    love.graphics.draw(image, 0, 0, 0, scale)
    draw_grid(windowWidth, windowHeight, scale)
end

function draw_grid(width, height, grid_size)
    love.graphics.getBlendMode("replace")
    love.graphics.setColor(0.1, 0.1, 0.1)
    for x = grid_size, width, grid_size do
        love.graphics.line(x, 0, x, height)
    end
    for y = grid_size, height, grid_size do
        love.graphics.line(0, y, width, y)
    end
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.getBlendMode("alpha")
end

function step()
    -- love.graphics.setBlendMode("alpha")
    love.graphics.setCanvas(canvas)
    love.graphics.setShader(shader)
    love.graphics.draw(image)
    love.graphics.setShader()
    love.graphics.setCanvas()

    data = canvas:newImageData()
    image = love.graphics.newImage(data)
    image:setFilter("linear", "nearest")
end
