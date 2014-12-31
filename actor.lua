require 'action_queue'
require 'action_lock'

Actor = class(function(self, job) 
    self.job = job
    self.auras = {}
    self.received_damage = 0;
    self.lock = ActionLock()
    self.queue = ActionQueue()
  end)

function Actor:apply_damage(damage)
  self.received_damage = self.received_damage + damage
end

function Actor:apply_aura(aura)
  table.insert(self.auras, aura)
  aura:on_apply()
end