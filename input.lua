module(..., package.seeall)

function handle(dt)
	-- Player movement.
    player.angle = -1
    if love.keyboard.isDown("w") and love.keyboard.isDown("d") then
        player.angle = 315
    elseif love.keyboard.isDown("w") and love.keyboard.isDown("a") then
        player.angle = 225
    elseif love.keyboard.isDown("s") and love.keyboard.isDown("d") then
        player.angle = 45
    elseif love.keyboard.isDown("s") and love.keyboard.isDown("a") then
        player.angle = 135
    elseif love.keyboard.isDown("w") then
        player.angle = 270
    elseif love.keyboard.isDown("s") then
        player.angle = 90
    elseif love.keyboard.isDown("a") then
        player.angle = 180
    elseif love.keyboard.isDown("d") then
        player.angle = 0
    end


    if love.keyboard.isDown("c") then
        enemies[#enemies+1] = Enemy.create()
    end

    if love.keyboard.isDown("v") then
        for i, enemy in ipairs(enemies) do
            enemy.speed = enemy.maxSpeed
        end
    end

end


function love.keypressed(key)
    if key == "escape" then
        love.mouse.setVisible(true)
        love.event.push("quit")
    end

    if key == "r" then
        love.filesystem.load("main.lua")()
        love.load()
    end

    if key == "lshift" then
        player:toggleState()
    end

    if key == "rshift" then
        if global.debug then
            global.debug = false
            love.graphics.setFont(font)
        else
            global.debug = true
            love.graphics.setFont(normalFont)            
        end
    end

    if key == "x" then
        enemies[#enemies+1] = Enemy.create()
    end
end