module(..., package.seeall)

function create()
    local this = {}
    this.x = math.random(50, SW-50)
    this.y = math.random(50, SH-50)
    while util.getDistance(this, player) < 100 do
        this.x = math.random(50, SW-50)
        this.y = math.random(50, SH-50)
    end
    this.radius = 14
    this.width = this.radius*2
    this.height = this.radius*2
    this.speed = 0
    this.angle = 0
    this.age = 0
    this.spawnAge = math.random(100, 300)
    this.maxSpeed = 2
    this.speedInterval = 0.0015
    this.state = "spawning"
    this.toggledPlayer = false

    this.p = love.graphics.newParticleSystem(part1, 40)
    this.p:setEmissionRate(40)
    this.p:setSpeed(5, 50)
    this.p:setParticleLife(0.5)
    this.p:setSpread(math.rad(360))
    util.setPsColor(this.p, COLOR_SPAWN)
    this.p:start()

    function this:isActive()
        return this.state ~= "spawning" and this.state ~= "dead"
    end

    function this:updateSpawn(dt)
        this.age = this.age + 1
        if this.age == this.spawnAge then
            if math.random(0,1) == 1 then
                util.setPsColor(this.p, COLOR_FIRE)
                this.state = "fire"
            else
                util.setPsColor(this.p, COLOR_WATER)
                this.state = "water"
            end
        end
    end

    function this:updateDeath(dt)
        this.age = this.age - 1
    end

    function this:update(dt)
        if this.state == "spawning" then
            this:updateSpawn(dt)

            if this.toggledPlayer == false and util.isColliding(this, player) then
                this.toggledPlayer = true
                player:toggleState()
            end
        elseif this.state == "dead" then
            this:updateDeath(dt)
        else -- Not spawning or dead.
            if this.speed < this.maxSpeed then this.speed = this.speed + this.speedInterval end

            -- Player collision.
            if util.isColliding(this, player) then
                if this.state == player.state then
                    this.state = "dead"
                    this.age = 100
                    player.score = player.score + #enemies * 10
                    this.p:setParticleLife(3)
                    this.p:setSpeed(10, 100)
                else
                    player.state = "dead"
                end
            end

            -- -- Bomb collision.
            if bomb:isActive() and util.isColliding(this, bomb) and util.isColliding(this, bomb.inner) == false then
                this.state = "dead"
                this.age = 100
                this.p:setParticleLife(3)
                this.p:setSpeed(10, 100)
            end

            -- Enemy Collision.  (Flocking)
            local isCollidingWithEnemy = false
            for i, enemy in ipairs(enemies) do
                if this ~= enemy and util.isColliding(this, enemy) then
                    local collisionAngle = util.getAngle(enemy, this)
                    isCollidingWithEnemy = true
                    this.angle = collisionAngle
                end
            end

            if isCollidingWithEnemy == false then
                util.updateAngle(this, player)
            end

            util.updateCords(this, this.angle, this.speed)
        end

        this.p:setPosition(this.x, this.y)
        this.p:update(dt)
    end

    function this:draw()
        util.drawParticleSystem(this.p)
        util.drawDebug(this)
    end

    return this
end
