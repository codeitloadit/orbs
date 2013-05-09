module(..., package.seeall)

function create()
    local this = {}
    this.x = SW/2
    this.y = SH/2
    this.radius = 8
    this.width = this.radius*2
    this.height = this.radius*2

    this.p = love.graphics.newParticleSystem(part1, 1000)
    this.p:setEmissionRate(1000)
    this.p:setSpeed(50, 150)
    this.p:setSizes(0.5, 0.4, 0.3)
    this.p:setColors(51, 204, 51, 255, 0, 0, 0, 0)
    this.p:setParticleLife(0.1)
    this.p:setSpread(math.rad(360))
    this.p:start()

    function this:update(dt)
        this.x = love.mouse.getX()
        this.y = love.mouse.getY()
        this.p:setPosition(this.x, this.y)
        this.p:update(dt)
    end

    function this:draw()
        util.drawParticleSystem(this.p)
        util.drawDebug(this)
    end

    return this
end
