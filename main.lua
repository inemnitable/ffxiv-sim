__ = require 'underscore'
require("class")
require("simulation")
require("rotation")
require("skill")

local rot = Rotation("dragoon")
local sim = Simulation(rot)

return sim:run()