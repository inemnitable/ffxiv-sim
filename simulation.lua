require "actor"

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
  repeat 
    local increment = self:do_action()
    print(self.time, increment)
  until increment
  self.time = self.time + 1
end

--return true if time should be incremented
function Simulation:do_action()
  local actor = self.actor
  local target = self.target
  if actor.lock:locked(self) then
    print("locked")
    return true
  end
  print "getting next action from queue"
  local next_action, block = actor.queue:next_action(self)
  if next_action then
    next_action()
    print "performed action from queue"
    return false
  elseif block then
    print "blocked"
    return true
  end
  print "getting action from rotation"
  next_action = actor.rotation(self, actor, target)
  if next_action then
    print "performing action from rotation"
    next_action()
    print "performed action from rotation"
    return false
  else
    print "no more action for this time step"
    return true
  end
end
