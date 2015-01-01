local dragoon = {
  true_thrust = {
    affinity = {"dragoon", "lancer"},
    potency = 150,
    effect = function(self, sim, actor, target)
      local effect = Effect()
      effect.buff = {Aura.combo("vorpal_thrust_combo")}
      return effect
    end,
    animation = 50,
    gcd = true,
  },

  vorpal_thrust = {
    affinity = {"dragoon", "lancer"},
    potency = function(actor)
      return actor.has_aura_with_name("vorpal_thrust_combo") and
        200 or 100
    end,
    effect = function(self, sim, actor, target)
      local effect = Effect()
      effect.buff = {Aura.combo("full_thrust_combo")}
      return effect
    end,
    animation = 50,
    gcd = true,
  },
}

local function rotation(t, sim, actor, target)
  print "sim"
  for k,v in pairs(sim) do print(k,v) end
  print "actor"
  for k,v in pairs(actor) do print(k,v) end
  print "target"
  for k,v in pairs(target) do print(k,v) end
  -- print("rotation got actor", actor, "target", target)
  if actor.lock:on_gcd(sim) then return end
  local skill = dragoon.true_thrust
  return function()
    -- print(skill, actor, target)
    perform_skill(sim, skill, actor, target)
  end
end

local mt = {
  __call = rotation,
}

return setmetatable(dragoon, mt)