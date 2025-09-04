local config = {}

local set_default_font = function()
    love.graphics.setFont(love.graphics.newFont("assets/m5x7.ttf", 60))
    love.graphics.setDefaultFilter("nearest", "nearest")
end

local set_window_parameters = function(width, height)
    love.window.setTitle("Led Balloon")
    love.window.setMode(width, height)
end

config.load = function()
    math.randomseed(os.time())
    set_default_font()

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
    score = 0

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
    phaser_beams = {}
    pew = love.audio.newSource("assets/phaser_beam.wav", "static")
    music = love.audio.newSource("assets/lead_balloon_theme.wav", "stream")
    music:setLooping(true)
end

return config