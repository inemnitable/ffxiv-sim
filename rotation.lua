Rotation = {}

local mt = getmetatable(Rotation) or {}
mt.__index = function(tab, k)
  local rot = require("jobs/"..k)
  if not rot then rot = function() return end end
  tab[k] = rot
  return rot
end
setmetatable(Rotation, mt)