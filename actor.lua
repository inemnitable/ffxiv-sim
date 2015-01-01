require 'action_queue'
require 'action_lock'

Actor = class(function(self, job, rotation)
    self.job = job
    self.rotation = rotation or job and Rotation[job]
    self.auras = {}
    self.received_damage = 0;
    self.lock = ActionLock()
    self.queue = ActionQueue()
    self.attributes = {}
  end)

function Actor:apply_damage(damage)
  self.received_damage = self.received_damage + damage
end

function Actor:notify_server_tick()
  __.invoke(self.auras, "on_server_tick")
end

function Actor:apply_auras(sim, auras)
  --applies a buffs or debuffs to this actor
  --accepts a single aura or an array of auras
  if type(auras) ~= "table" then auras = { auras } end
  for _,aura in ipairs(auras) do
    table.insert(self.auras, aura)
    aura:on_apply(sim, self)
  end
end

function Actor:expire_auras(sim)
  --checks this actor's auras for expiration
  self.auras = __.reject(self.auras, function(aura)
      if aura:is_expired(sim) then
        aura:on_remove()
        return true
      else
        return false
      end
    end)
end

function Actor:base_damage()
  --calculate this actor's base damage from stats
  return 100
end

function Actor:mitigate(effect)
  --calculate dodge, block, and parry rates
  --set a flag on the effect to prevent critical
end

function Actor:critical(effect)
  --roll for critical and apply necessary transformation to effect
end

function Actor:gcd()
  --TODO: calculate the GCD from stats
  return 250
end