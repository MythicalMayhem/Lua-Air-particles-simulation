local atoms = {}
atoms.hydrogen = {}
function atoms.hydrogen:new()
    local obj = {}
    obj.color = {1,0,1}
    obj.mass =  1 --× 10^-24 g
    obj.radius =  5  --× 10^-24 g
    obj.pos = {
        x = math.random(0 + obj.mass, love.graphics.getWidth() - obj.mass),
        y = math.random(0 + obj.mass, love.graphics.getHeight() - obj.mass)
    }
    obj.velocity = {
        x =math.random(-1, 1) * math.random(),
        y = math.random(-1, 1) * math.random()
    }
    obj.direction = function()
        normCoef = 0
        if not ((obj.velocity.x == 0) and (obj.velocity.y == 0)) then
            normCoef = 1 / math.sqrt(obj.velocity.x ^ 2 + obj.velocity.y ^ 2)
        end
        return normCoef
    end
    return obj
end
return atoms
