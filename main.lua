function love.load()
    game_over = false
    require("config").load()
    guns = require("phaser")
    -- Multiple aliens
    alien_speed = 20
    alien_spawn_timer = 0
    alien_spawn_interval = 1.5
    min_alien_spawn_interval = 0.4
    active_aliens = {}
    music:play()
end

function love.update(dt)
    if game_over then return end
    if love.keyboard.isDown("k") then
        ship_pos_x = ship_pos_x + 50 * dt
    elseif love.keyboard.isDown("j") then
        ship_pos_x = ship_pos_x - 50 * dt
    end

    guns.update_phaser_beams(dt)

    -- Spawn aliens at intervals
    -- Decrease spawn interval as score increases
    local dynamic_spawn_interval = math.max(min_alien_spawn_interval, alien_spawn_interval - (score * 0.07))
    alien_spawn_timer = alien_spawn_timer + dt
    if alien_spawn_timer >= dynamic_spawn_interval then
        alien_spawn_timer = 0
        local spawn_x = math.random(0, VIRTUAL_WIDTH - 8)
        local sprite = aliens[math.random(#aliens)]
        table.insert(active_aliens, {x = spawn_x, y = -8, sprite = sprite, alive = true})
    end

    -- Move aliens down
    for i = #active_aliens, 1, -1 do
        local a = active_aliens[i]
        a.y = a.y + alien_speed * dt
        -- Remove if fully off screen (bottom of alien past screen)
        if (a.y + 8) > VIRTUAL_HEIGHT then
            table.remove(active_aliens, i)
        else
            -- Check collision with ship, but do NOT remove alien
            local ship_left = ship_pos_x
            local ship_right = ship_pos_x + SHIP_WIDTH
            local ship_top = ship_pos_y
            local ship_bottom = ship_pos_y + SHIP_HEIGHT
            local alien_left = a.x
            local alien_right = a.x + 8
            local alien_top = a.y
            local alien_bottom = a.y + 8
            if alien_right > ship_left and alien_left < ship_right and alien_bottom > ship_top and alien_top < ship_bottom then
                game_over = true
            end
        end
    end

    -- Check collision between phaser beams and aliens
    for ai = #active_aliens, 1, -1 do
        local a = active_aliens[ai]
        for bi = #phaser_beams, 1, -1 do
            local beam = phaser_beams[bi]
            local beam_left = beam.x - 1
            local beam_right = beam.x + 1
            local beam_top = beam.y
            local beam_bottom = beam.y + 6
            local alien_left = a.x
            local alien_right = a.x + 8
            local alien_top = a.y
            local alien_bottom = a.y + 8
            if beam_right > alien_left and beam_left < alien_right and beam_bottom > alien_top and beam_top < alien_bottom then
                score = score + 1
                table.remove(active_aliens, ai)
                table.remove(phaser_beams, bi)
                break
            end
        end
    end
end

function love.draw()
    render_score()
    if not game_started then
        draw_start_message()
        return
    end

    love.graphics.push()
    love.graphics.scale(scale)

    guns.draw_phaser_beams()
    -- Draw all aliens
    for _, a in ipairs(active_aliens) do
        love.graphics.draw(a.sprite, a.x, a.y)
    end
    love.graphics.draw(ships[math.random(#ships)], ship_pos_x, ship_pos_y)

    if game_over then
        love.graphics.setColor(1, 0, 0)
        local msg = "GAME OVER"
        local font = love.graphics.getFont()
        local text_width = font:getWidth(msg)
        local text_height = font:getHeight()
        love.graphics.print(msg, window_width / 2 - text_width / 2, window_height / 2 - text_height / 2)
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.pop()
end

function love.keypressed(key)
    if key == "space" then
        if not game_started then
            game_started = true
            start_message = ""
            return
        end
        pew:play()
        guns.shoot_phaser()
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