local dragoon = {}
dragoon.true_thrust = Action(function(sim, actor, target)
    local affinity = {"dragoon", "lancer"}
    local potency = 150
    if not __.include(affinity, actor.type) then return end
    local effect = Effect()
    local base_damage = actor:base_damage()
    effect.damage = base_damage * potency / 100
    for _,aura in ipairs(actor.auras) do
      aura:modify_effect(effect, "perform")
    end
    for _,aura in ipairs(target.auras) do
      aura:modify_effect(effect, "receive")
    end
    actor.lock:animate(sim, 50)
    actor.lock:start_gcd(sim, actor.gcd)
    local application = function() 
      target:apply_damage(effect.damage)
      target:apply_aura(effect.debuff)
      actor:apply_aura(effect.buff)
    end
    actor.queue:enqueue(application)
  end
)