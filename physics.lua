function response_velocities(a, b)
    local respAX = ((a.mass - b.mass) * a.velocityX + (2 * b.mass * b.velocityX)) / (a.mass + b.mass)
    local respAY = ((a.mass - b.mass) * a.velocityY + (2 * b.mass * b.velocityY)) / (a.mass + b.mass)
    local respBX = ((b.mass - a.mass) * b.velocityX + (2 * a.mass * a.velocityX)) / (a.mass + b.mass)
    local respBY = ((b.mass - a.mass) * b.velocityY + (2 * a.mass * a.velocityY)) / (a.mass + b.mass)
    return {{respAX, respAY}, {respBX, respBY}}

end
 