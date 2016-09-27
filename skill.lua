Action = class(function(self, func) 
    local mt = getmetatable(self) or {}
    mt.__call = func
    setmetatable(self, mt)    
  end)

function Action:is_ready()
  return true
end

function Action:should_block()
  return false
end

function Action:respect_lock()
  return true
end

Skill = class(function(self, actor, target, func)
    self.actor = actor
    self.target = target
    self:super(func)
  end, Action)

function perform_skill(sim, skill, actor, target)
  assert(__.include(skill.affinity, actor.job),
    "this job cannot perform this skill!")
  local potency = type(skill.potency) == "function" and
    skill.potency(actor) or skill.potency
  local base_damage = actor:skill_damage()
  local effect = type(skill.effect) == "function" and skill.effect() or skill.effect
  effect.damage = base_damage * potency / 100
  for _,aura in ipairs(actor.auras) do
    aura(effect, "perform")
  end
  for _, aura in ipairs(actor.auras) do
    aura(effect, "receive")
  end
  target:mitigate(effect)
  actor:critical(effect)
  actor.lock:animate(sim, skill.animation)
  if skill.gcd then actor.lock:start_gcd(sim, actor:gcd()) end
  local application = Action(function()
      target:apply_damage(effect.damage)
      target:apply_auras(sim, effect.debuff)
      actor:apply_auras(sim, effect.buff)
    end
  )
  actor.queue:enqueue(application)
end
