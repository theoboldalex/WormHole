function love.load()
    require("config").load()
    phaser = require("phaser")
    music:play()
end

function love.update(dt)
    if love.keyboard.isDown("k") then
        ship_pos_x = ship_pos_x + 50 * dt
    elseif love.keyboard.isDown("j") then
        ship_pos_x = ship_pos_x - 50 * dt
    end

    phaser.update_phaser_beams(dt)
end

function love.draw()
    render_score()
    if not game_started then
        draw_start_message()
        return
    end

    love.graphics.push()
    love.graphics.scale(scale)

    phaser.draw_phaser_beams()
    -- sprites
    love.graphics.draw(aliens[1], VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2)
    love.graphics.draw(ships[math.random(#ships)], ship_pos_x, ship_pos_y)
    love.graphics.pop()
end

function love.keypressed(key)
    if key == "space" then
        if not game_started then
            game_started = true
            start_message = ""
            return
        end
        bullet:play()
        phaser.shoot_phaser()
    end
end

function render_score()
    love.graphics.print("Score: " .. tostring(score), 5, 5)
end

function draw_start_message()
    local font = love.graphics.getFont()
    local text_width = font:getWidth(start_message)
    local text_height = font:getHeight()
    
    love.graphics.print(start_message, window_width / 2 - text_width / 2, window_height / 2 - text_height / 2)
end