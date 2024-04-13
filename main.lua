local utils = require('./utils')
local settings = require('./settings')
local physics = require('./physics')
local templates = require('./templates')
math.randomseed(os.time())
local printstr = ''
 
local atoms = {}
function love.load()
    for i = 1, settings.gasCloud do
        atoms[i] = templates.hydrogen:new()
    end
end




local fps = 0
local debounce = os.time()
function love.update(dt)
    if os.time() -debounce >0.05 then 
        fps = 1/dt
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
                -- collisionCheck(atom, neighbor)
            end
        end
        atom.pos.x = atom.pos.x + atom.velocity.x
        atom.pos.y = atom.pos.y + atom.velocity.y
    end
end

function love.draw()
    love.graphics.setColor(1,1,1)
    love.graphics.print(tostring(fps))
    love.graphics.print(tostring('\n'..printstr))
    for k, atom in ipairs(atoms) do
        love.graphics.setColor(atom.color[1], atom.color[2], atom.color[3])
        love.graphics.circle("fill", atom.pos.x, atom.pos.y, atom.mass)
    end
end
