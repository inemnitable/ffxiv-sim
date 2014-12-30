ActionLock = class(function(self) 
    self.gcd = 0
    self.lock = 0
  end)

function ActionLock:gcd(sim)
  return sim.time >= self.gcd
end

function ActionLock:locked(sim)
  return sim.time >= self.lock
end

function ActionLock:gcd_remaining(sim)
  local ret = self.gcd - sim.time
  return ret >= 0 and ret or 0
end