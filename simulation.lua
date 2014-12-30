require "action_lock"
require "action_queue"

Simulation = class(function(self, rotation) 
    self.lock = ActionLock()
    self.queue = ActionQueue()
    self.time = 0
    self.rotation = rotation
  end)

function Simulation:run() 
  --TODO: do stuff
  return
end