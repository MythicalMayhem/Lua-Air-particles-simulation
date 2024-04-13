local utils = require('./utils')
math.randomseed(os.time())

local atom = {}
function atom:new()
    local obj = {}

    obj.color = {math.random(), math.random(), math.random()}
    obj.mass = 50
    obj.pos = {
        x = math.random(0 + obj.mass, love.graphics.getWidth() - obj.mass),
        y = math.random(0 + obj.mass, love.graphics.getHeight() - obj.mass)
    }
    obj.velocity = {
        x =  math.random(-1,1)*math.random(),
        y = math.random(-1,1)*math.random()
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
function love.load()
    particles = {}
    for i = 1, 10 do
        particles[i] = atom:new()
    end
end

local a = ''
local d

function love.update(dt)
    d = 1 / dt
    for k, particle in pairs(particles) do
        local dir = particle.direction()
        a = dir
        local nextStep = {
            x = particle.pos.x + particle.mass* utils.sign(particle.velocity.x),
            y = particle.pos.y + particle.mass *utils.sign(particle.velocity.y)
        }
        if not ((nextStep.x >= 0) and (nextStep.x <= love.graphics.getWidth())) then
            particle.velocity.x = particle.velocity.x * -1
        end
        if not ((nextStep.y >= 0) and (nextStep.y <= love.graphics.getHeight())) then
            particle.velocity.y = particle.velocity.y * -1
        end
        for l, neighbor in pairs(particles) do
            if not (neighbor == particle) then
                -- collisionCheck(particle, neighbor)
            end
        end
        particle.pos.x = particle.pos.x + particle.velocity.x
        particle.pos.y = particle.pos.y + particle.velocity.y
    end
end

function love.draw()
    love.graphics.print(tostring(a))
    for k, particle in ipairs(particles) do

        love.graphics.setColor(particle.color[1], particle.color[2], particle.color[3])
        love.graphics.circle("fill", particle.pos.x, particle.pos.y, particle.mass)
    end
end
