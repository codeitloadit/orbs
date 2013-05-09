module(..., package.seeall)

function create()
    local this = {}
    this.x = SW/2
    this.y = SH/2
    this.radius = 10
    this.width = this.radius*2
    this.height = this.radius*2
    this.speed = 0
    this.maxSpeed = 9
    this.angle = -1
    this.state = "fire"
    this.score = 0
    this.scoreColor = COLOR_FIRE
    this.scoreColor[4] = 255

    this.p = love.graphics.newParticleSystem(part1, 200)
    this.p:setEmissionRate(200)
    this.p:setSpeed(5, 10)
    this.p:setSizes(1)
    this.p:setParticleLife(0.5)
    this.p:setSpread(math.rad(360))
    util.setPsColor(this.p, COLOR_FIRE)
    this.p:start()

    function this:isActive()
        return this.state ~= "dead"
    end


    function this:toggleState()
        if this.state == "fire" then
            this.state = "water"
            util.setPsColor(this.p, COLOR_WATER)
            this.scoreColor = COLOR_WATER
        else
            this.state = "fire"
            util.setPsColor(this.p, COLOR_FIRE)
            this.scoreColor = COLOR_FIRE
        end
        this.scoreColor[4] = 255
    end

    function this:update(dt)
        local mouse = {
            x = love.mouse.getX(),
            y = love.mouse.getY()
        }
        local dist = util.getDistance(this, mouse)

        this.speed = dist/50
        if this.speed > this.maxSpeed then this.speed = this.maxSpeed end

        util.updateAngle(this, mouse)
        util.updateCords(this, this.angle, this.speed)

        -- Keep player within screen bounds.
        if this.x < this.radius then this.x = this.radius end
        if this.x > SW - this.radius then this.x = SW - this.radius end
        if this.y < this.radius then this.y = this.radius end
        if this.y > SH - this.radius then this.y = SH - this.radius end

        this.p:setPosition(this.x, this.y)
        this.p:update(dt)
    end

    function this:draw()
        util.drawParticleSystem(this.p)
        util.drawDebug(this)
    end

    return this
end
