Simulation = class(function(self, actor, target) 
    self.time = 0
    self.actor = actor
    self.target = target
  end)

function Simulation:run(duration) 
  --TODO: do stuff
  self.time = 0
  self.target.received_damage = 0

  while (self.time < duration) do
    self:time_step()
  end
  return self.target.received_damage / (duration / 100)
end

function Simulation:time_step()
  local actors = {self.actor, self.target}
  if self.time % 300 == 0 then
    __.invoke(actors, "notify_server_tick")
  end
  __.invoke(actors, "expire_auras", self)
  repeat until self:do_action()
  self.time = self.time + 1
end

--return true if time should be incremented
function Simulation:do_action()
  local actor = self.actor
  local target = self.target
  if actor.lock:locked(self) then return true end
  local next_action, block = actor.queue:next_action(self)
  if next_action then
    next_action()
    return false
  elseif block then return true end
  next_action = actor.rotation(self, actor, target)
  if next_action then
    next_action()
    return false
  else
    return true
  end
end
