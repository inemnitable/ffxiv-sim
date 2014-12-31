Aura = class(function(self, func, mode, duration)
    local mt = getmetatable(self)
    mt.__call = function(effect, m)
      if m == mode then
        func(effect)
      end
    end
    setmetatable(self, mt)
    self.duration = duration
    self.apply_time = -duration
  end)

function Aura:on_apply(sim, actor)
  self.apply_time = sim.time
end

function Aura:on_remove(sim, actor)
  return
end

function Aura:is_expired(sim)
  return self.apply_time + self.duration < sim.time
end