ActionLock = class(function(self) 
    self.gcd = 0
    self.lock = 0
  end)

function ActionLock:on_gcd(sim)
  return sim.time < self.gcd
end

function ActionLock:locked(sim)
  return sim.time < self.lock
end

function ActionLock:gcd_remaining(sim)
  local ret = self.gcd - sim.time
  return ret >= 0 and ret or 0
end

function ActionLock:animate(sim, duration)
  self.lock = sim.time + duration
end

function ActionLock:start_gcd(sim, gcd)
  self.gcd = sim.time + gcd
end