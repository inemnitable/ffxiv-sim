require("class")
require("simulation")
require("rotation")
require("skill")

local rot = Rotation("dragoon")
local sim = Simulation(rot)

local dk = DragonKick(3, 5)
print(dk.target)
print(dk.actor)

return sim:run()