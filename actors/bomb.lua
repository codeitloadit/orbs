module(..., package.seeall)

function create()
    local this = {}
    this.x = math.random(50, SW-50)
    this.y = math.random(50, SH-50)
    this.radius = 18
    this.width = this.radius*2
    this.height = this.radius*2
    this.state = "idle"
    this.age = 0

    this.inner = {}
    this.inner.x = this.x
    this.inner.y = this.y
    this.inner.radius = 0
    this.inner.width = this.inner.radius*2
    this.inner.height = this.inner.radius*2

    this.p = love.graphics.newParticleSystem(part1, 1000)
    this.p:setEmissionRate(1000)
    this.p:setSpeed(100, 150)
    this.p:setSizes(1.0, 0.9, 0.8, 0.7, 0.6, 0.5)
    this.p:setParticleLife(0.25)
    this.p:setSpread(math.rad(360))
    this.p:setPosition(this.x, this.y)
    util.setPsColor(this.p, COLOR_BOMB)
    this.p:start()

    function this:isActive()
        return this.state ~= "idle" and this.state ~= "dead"
    end

    function this:update(dt)
        if this.state == "idle" then
            if util.intersects(this, player) then
                this.p:setParticleLife(4)
                this.p:setSpeed(200, 200)
                this.state = "active"
            end
        end

        if this.state == "active" then
            this.age = this.age + 1
            this.radius = this.radius + 3
            this.inner.radius = this.inner.radius + 3
            if this.age == 10 then
                this.p:stop()
            elseif this.age == 100 then
                this.state = "dead"
            end
        end

        this.p:update(dt)
    end

    function this:draw()
        util.drawParticleSystem(this.p)
        util.drawDebug(this)
    end

    return this
end
