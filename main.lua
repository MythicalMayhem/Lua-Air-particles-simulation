local utils = require('./utils')
local settings = require('./settings')
local physics = require('./physics')
local templates = require('./templates')
math.randomseed(os.time())
local printstr = ''
function collisionCheck(a, b)
    local distance = math.sqrt((a.pos.x - b.pos.x) ^ 2 + (a.pos.y - b.pos.y) ^ 2)
    if distance <= (a.mass + b.mass) then
        a.velocity.x, a.velocity.y, b.velocity.x, b.velocity.y = physics.response_velocities(a, b)
        a.pos.x = a.pos.x + a.velocity.x
        a.pos.y = a.pos.y + a.velocity.y
        b.pos.x = b.pos.x + b.velocity.x
        b.pos.y = b.pos.y + b.velocity.y
    end
end
local atoms = {}
 
local BB = math.random(0, love.graphics.getHeight() - 1)
local line = {
    b = BB,
    a  = (love.graphics.getHeight() - BB - BB) / (love.graphics.getWidth() - 0),
    x = 0,
    y = BB,
    x2 = love.graphics.getWidth(),
    y2 = love.graphics.getHeight() - BB,

}


function love.load()
 
      -- y = ax +b


    local sign = -1
    local n = 100
    local chunk = (line.x2 - line.x-200 ) / n
    for i = 1, n do
        sign = -sign
        local margin = math.random(-50, 50)
        local temp = templates.hydrogen:new()
        local x = chunk * i + 100
        local y = line.a * x + line.b + ((n / 2) - math.abs((n / 2) - i)) * sign + margin


        temp.pos.x = math.min(love.graphics.getWidth(), x)
        temp.pos.y = math.min(love.graphics.getHeight(), y)
        if not (temp.x == love.graphics.getWidth() or temp.y == love.graphics.getHeight()) then
            atoms[i] = temp

        end
    end
end

local fps = 0
local debounce = os.time()
function love.update(dt)
    if os.time() - debounce > 0.05 then
        fps = 1 / dt
        debounce = os.time()
    end
    for k, atom in pairs(atoms) do
        local dir = atom.direction()

        local nextStep = {
            x = atom.pos.x + atom.mass * utils.sign(atom.velocity.x),
            y = atom.pos.y + atom.mass * utils.sign(atom.velocity.y)
        }
        if not ((nextStep.x >= 0) and (nextStep.x <= love.graphics.getWidth())) then
            atom.velocity.x = atom.velocity.x * -1
        end
        if not ((nextStep.y >= 0) and (nextStep.y <= love.graphics.getHeight())) then
            atom.velocity.y = atom.velocity.y * -1
        end
        for l, neighbor in pairs(atoms) do
            if not (neighbor == atom) then
                collisionCheck(atom, neighbor)
            end
        end
        atom.pos.x = atom.pos.x + atom.velocity.x
        atom.pos.y = atom.pos.y + atom.velocity.y
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(tostring(fps))
    love.graphics.print(tostring('\n' .. printstr))
    love.graphics.line( line.x,line.y,line.x2,line.y2 )
    for k, atom in ipairs(atoms) do
        love.graphics.setColor(atom.color[1], atom.color[2], atom.color[3])
        love.graphics.circle("fill", atom.pos.x, atom.pos.y, atom.mass)
    end
end
