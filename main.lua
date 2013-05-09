Player = require("actors/player")
Cursor = require("actors/cursor")
Enemy = require("actors/enemy")
Bomb = require("actors/bomb")

function love.load()
    input = require("input")
    util = require("util")

    normalFont = love.graphics.newFont(love._vera_ttf, 10)
    font = love.graphics.newImageFont("assets/monofontgray5.png",
        " abcdefghijklmnopqrstuvwxyz" ..
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ0" ..
        "123456789.,!?-+/():;%&`'*#=[]\"")
    if global.debug then
        love.graphics.setFont(normalFont) 
    else
        love.graphics.setFont(font)       
    end

    love.mouse.setVisible(false)
    part1 = love.graphics.newImage("assets/part1.png");
    love.graphics.setBackgroundColor(0, 0, 0)

    player = Player.create()

    maxEnemies = 50
    enemies = {}
    for i = 1, 8, 1 do
        enemies[#enemies+1] = Enemy.create()
    end

    bomb = Bomb.create()

end

function love.update(dt)
	input.handle(dt)

    if player:isActive() then
        player:update(dt)

        for i, enemy in ipairs(enemies) do
            enemy:update(dt)
            if enemy.age <= 0 then
                table.remove(enemies, i)
                if #enemies < maxEnemies then
                    enemies[#enemies+1] = Enemy.create()
                    enemies[#enemies+1] = Enemy.create()
                end
            end
        end

        bomb:update(dt)
        if bomb.state == "dead" then
            bomb = Bomb.create()
        end
    end
end

function love.draw()
    love.graphics.setColor(player.scoreColor)
    love.graphics.printf(tostring(player.score), 16, 0, SW-16, "center")

    if player:isActive() then
        if bomb then bomb:draw() end
        for i, enemy in ipairs(enemies) do
            enemy:draw()
        end
        player:draw()
    end

    if global.debug then
        love.graphics.setColor(240, 240, 240)
        love.graphics.print("FPS: "..tostring(love.timer.getFPS()..
            "\nEnemies: "..#enemies), 0, 0)
    end
end
