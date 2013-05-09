module(..., package.seeall)

function setPsColor(ps, color)
    local r = color[1]
    local g = color[2]
    local b = color[3]
    local a = color[4]
    ps:setColors(r, g, b, a, 0, 0, 0, 0)
end

function getDistance(a, b)
    return math.sqrt((a.x - b.x ) * ( a.x - b.x) + (a.y - b.y) * (a.y - b.y));
end

function isColliding(a, b)
    return getDistance(a, b) <= a.radius + b.radius;
end

function getAngle(object, target)
    return math.deg(math.atan2(target.y - object.y, target.x - object.x)) + 360;
end
function updateAngle(object, target)
    object.angle = getAngle(object, target)
end

function updateCords(object, angle, speed)
    if angle >= 0 then
        object.x = object.x + math.cos(math.rad(angle)) * speed;
        object.y = object.y + math.sin(math.rad(angle)) * speed;
    end
end

function drawParticleSystem(ps)
    if global.debug == false then
        love.graphics.setColorMode("modulate")
        love.graphics.setBlendMode("additive")
        love.graphics.draw(ps)
    end
end

function drawDebug(object)
    if global.debug then
        love.graphics.setBlendMode("alpha")
        love.graphics.setColor(255, 0, 0)
        -- love.graphics.rectangle("line", object.x-object.width/2, object.y-object.height/2, object.width, object.height)
        love.graphics.circle("line", object.x, object.y, object.radius)
    end
end

function intersects(a, b)
    return a.x + a.width > b.x and a.y + a.height > b.y and a.x < b.x + b.width and a.y < b.y + b.height
end