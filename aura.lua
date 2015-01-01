Aura = class(function(self, func, name, mode, duration)
    local mt = getmetatable(self) or {}
    --do this mode check here?
    mt.__call = function(effect, m)
      if m == mode then
        func(effect)
      end
    end
    setmetatable(self, mt)
    self.name = name
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

function Aura:on_server_tick(sim, actor)
  return
end

function Aura.combo(name)
  return Aura(function() return end, name, "perform", 1000)
end