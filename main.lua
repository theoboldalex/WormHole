function love.load()
    require("config").load()

    start_message = "PRESS SPACE TO START"
    game_started = false
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    ships = { 
        love.graphics.newImage("assets/ship1.png"),
        love.graphics.newImage("assets/ship2.png"),
    }
    aliens = {
        love.graphics.newImage("assets/alien1.png"),
        love.graphics.newImage("assets/alien2.png"),
    }
    xpos = 55
    ypos = 70
end

function love.update(dt)
    if not game_started then
        if love.keyboard.isDown("space") then
            game_started = true
            start_message = ""
        end
    end

    if love.keyboard.isDown("k") then
        xpos = xpos + 50 * dt
    elseif love.keyboard.isDown("j") then
        xpos = xpos - 50 * dt
    end
end

function love.draw()
    if not game_started then
        draw_start_message()
        return
    end

    love.graphics.scale(10, 10)
    love.graphics.draw(aliens[1], 20, 20)
    love.graphics.draw(ships[math.random(#ships)], xpos, ypos)
end

function draw_start_message()
    local font = love.graphics.getFont()
    local text_width = font:getWidth(start_message)
    local text_height = font:getHeight()
    
    love.graphics.print(start_message, window_width / 2 - text_width / 2, window_height / 2 - text_height / 2)
end