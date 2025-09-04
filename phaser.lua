local phaser = {}

phaser.shoot_phaser = function()
    local beam = {
        x = ship_pos_x + SHIP_WIDTH / 2,
        y = ship_pos_y,
        speed = 120
    }
    table.insert(phaser_beams, beam)
end

phaser.update_phaser_beams = function(dt)
    for i = #phaser_beams, 1, -1 do
        local beam = phaser_beams[i]
        beam.y = beam.y - beam.speed * dt
        if beam.y < 0 then
            table.remove(phaser_beams, i)
        end
    end
end

phaser.draw_phaser_beams = function()
    love.graphics.setColor(1, 1, 0)
    for _, beam in ipairs(phaser_beams) do
        love.graphics.rectangle("fill", beam.x - 1, beam.y, 2, 6)
    end
    love.graphics.setColor(1, 1, 1)
end

return phaser