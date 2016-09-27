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
      return actor:has_aura_with_name("vorpal_thrust_combo") and
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

  full_thrust = {
    affinity = {"dragoon", "lancer"},
    potency = function(actor)
      return actor:has_aura_with_name("full_thrust_combo") and
        360 or 100
    end,
    effect = Effect(),
    animation = 50,
    gcd = true,
  },
}

local function rotation(t, sim, actor, target)
  --return an action to enqueue
  if actor.lock:on_gcd(sim) then return end
  local skill
  if actor:has_aura_with_name("full_thrust_combo") then
  skill = dragoon.full_thrust
  elseif actor:has_aura_with_name("vorpal_thrust_combo") then
    skill = dragoon.vorpal_thrust
  else
    skill = dragoon.true_thrust
  end
  return function()
    perform_skill(sim, skill, actor, target)
  end
end

local mt = {
  __call = rotation,
}

return setmetatable(dragoon, mt)