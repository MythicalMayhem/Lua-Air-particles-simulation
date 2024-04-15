local physics = {
    G = -1 -- 6.67/(10^11)
}
function physics.response_velocities(a, b)
    local respAX = ((a.mass - b.mass) * a.velocity.x + (2 * b.mass * b.velocity.x)) / (a.mass + b.mass)
    local respAY = ((a.mass - b.mass) * a.velocity.y + (2 * b.mass * b.velocity.y)) / (a.mass + b.mass)
    local respBX = ((b.mass - a.mass) * b.velocity.x + (2 * a.mass * a.velocity.x)) / (a.mass + b.mass)
    local respBY = ((b.mass - a.mass) * b.velocity.y + (2 * a.mass * a.velocity.y)) / (a.mass + b.mass)
    return respAX, respAY, respBX, respBY
end
function physics.gForce(atom, neighbor)
    local dx = atom.pos.x - neighbor.pos.x
    local dy = atom.pos.y - neighbor.pos.y
    local d = math.sqrt(dx * dx + dy * dy)
    
    local F = -(atom.mass * neighbor.mass) / (d ^ 2)
    return dx,dy,F
end
return physics
