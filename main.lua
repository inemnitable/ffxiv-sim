__ = require 'underscore'
require("class")
require("action_queue")
require("action_lock")
require("simulation")
require("skill")
require("rotation")
require("actor")
require("effect")
require("aura")

local player = Actor("dragoon")
local target = Actor()
local sim = Simulation(player, target)

print(sim:run(60000))