function love.load()
    require("config").load()

    VIRTUAL_WIDTH = 160
    VIRTUAL_HEIGHT = 80
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    scale_x = window_width / VIRTUAL_WIDTH
    scale_y = window_height / VIRTUAL_HEIGHT
    scale = math.min(scale_x, scale_y)
    SHIP_WIDTH = 8
    SHIP_HEIGHT = 8
    ship_pos_x = VIRTUAL_WIDTH / 2 - SHIP_WIDTH
    ship_pos_y = VIRTUAL_HEIGHT / 0.69 - SHIP_HEIGHT

    start_message = "PRESS SPACE TO START"
    game_started = false
    ships = { 
        love.graphics.newImage("assets/ship1.png"),
        love.graphics.newImage("assets/ship2.png"),
    }
    aliens = {
        love.graphics.newImage("assets/alien1.png"),
        love.graphics.newImage("assets/alien2.png"),
    }
    love.graphics.setDefaultFilter("nearest", "nearest")

    music = love.audio.newSource("assets/lead_balloon_theme.wav", "stream")
    music:setLooping(true)
    music:play()
end

function love.update(dt)
    if not game_started then
        if love.keyboard.isDown("space") then
            game_started = true
            start_message = ""
        end
    end

    if love.keyboard.isDown("k") then
        ship_pos_x = ship_pos_x + 50 * dt
    elseif love.keyboard.isDown("j") then
        ship_pos_x = ship_pos_x - 50 * dt
    end
end

function love.draw()
    if not game_started then
        draw_start_message()
        return
    end

    love.graphics.push()
    love.graphics.scale(scale)

    love.graphics.setColor(0.1, 0.1, 0.1) -- Dark gray
    love.graphics.rectangle("fill", 0, 0, VIRTUAL_WIDTH/2 - 20, VIRTUAL_HEIGHT) -- left wall
    love.graphics.rectangle("fill", VIRTUAL_WIDTH/2 + 20, 0, VIRTUAL_WIDTH/2 - 20, VIRTUAL_HEIGHT) -- right wall
    love.graphics.setColor(1, 1, 1) -- Reset to white

    -- sprites
    love.graphics.draw(aliens[1], VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2)
    love.graphics.draw(ships[math.random(#ships)], ship_pos_x, ship_pos_y)
    love.graphics.pop()
end

function draw_start_message()
    local font = love.graphics.getFont()
    local text_width = font:getWidth(start_message)
    local text_height = font:getHeight()
    
    love.graphics.print(start_message, window_width / 2 - text_width / 2, window_height / 2 - text_height / 2)
end