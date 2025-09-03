local config = {}

local set_default_font = function()
    love.graphics.setFont(love.graphics.newFont("assets/8bit-tiny-retro.ttf", 60))
    love.graphics.setDefaultFilter("nearest", "nearest")
end

local set_window_parameters = function(width, height)
    love.window.setTitle("Led Balloon")
    love.window.setMode(width, height)
end

config.load = function()
    set_window_parameters(1200, 800)
    set_default_font()
end

return config