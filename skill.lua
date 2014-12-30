Action = class(function(self) return end)

function Action:perform()
  return
end

function Action:is_ready()
  return true
end

function Action:should_block()
  return false
end

Skill = class(function(self, actor, target)
    self.actor = actor
    self.target = target
    return
  end, Action)

DragonKick = class(function(self, actor, target)
    self:super(actor, target)
    return
  end, Skill)