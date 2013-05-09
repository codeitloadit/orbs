SW = 1280
SH = 800

COLOR_FIRE = {220, 105, 15, 255}
COLOR_WATER = {15, 105, 220, 255}
COLOR_HYPER = {255, 0, 255, 128}
COLOR_BOMB = {255, 15, 15, 255}
COLOR_SPAWN = {51, 204, 51, 255}

global = {}
global.debug = false
global.state = 0


function love.conf(t)
    t.title = "Shmup"        -- The title of the window the game is in (string)
    t.author = "Brian Ellis"        -- The author of the game (string)
    t.url = nil                 -- The website of the game (string)
    t.identity = nil            -- The name of the save directory (string)
    t.version = "0.8.0"         -- The LÖVE version this game was made for (string)
    t.console = false           -- Attach a console (boolean, Windows only)
    t.release = false           -- Enable release mode (boolean)
    t.screen.width = SW        -- The window width (number)
    t.screen.height = SH       -- The window height (number)
    t.screen.fullscreen = true -- Enable fullscreen (boolean)
    t.screen.vsync = true       -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
    t.modules.joystick = true   -- Enable the joystick module (boolean)
    t.modules.audio = true      -- Enable the audio module (boolean)
    t.modules.keyboard = true   -- Enable the keyboard module (boolean)
    t.modules.event = true      -- Enable the event module (boolean)
    t.modules.image = true      -- Enable the image module (boolean)
    t.modules.graphics = true   -- Enable the graphics module (boolean)
    t.modules.timer = true      -- Enable the timer module (boolean)
    t.modules.mouse = true      -- Enable the mouse module (boolean)
    t.modules.sound = true      -- Enable the sound module (boolean)
    t.modules.physics = true    -- Enable the physics module (boolean)
end