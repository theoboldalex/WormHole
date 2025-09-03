function love.load()
    require("config").load()

    start_message = "PRESS SPACE TO START"
    game_started = false
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    
end

function love.update(dt)
    if not game_started then
        if love.keyboard.isDown("space") then
            game_started = true
            start_message = ""
        end
    end
end

function love.draw()
    if not game_started then
        draw_start_message()
        return
    end
end

function draw_start_message()
    local font = love.graphics.getFont()
    local text_width = font:getWidth(start_message)
    local text_height = font:getHeight()
    
    love.graphics.print(start_message, window_width / 2 - text_width / 2, window_height / 2 - text_height / 2)
end