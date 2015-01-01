__ = require 'underscore'
require("class")
require("simulation")
require("skill")
require("rotation")
require("actor")
require("effect")
require("aura")

local player = Actor("dragoon")
local target = Actor()
local sim = Simulation(player, target)

print(sim:run(10000))