Action = class(function(self, func) 
    local mt = getmetatable(self)
    mt.__call = func
    setmetatable(self, mt)    
  end)

function Action:is_ready()
  return true
end

function Action:should_block()
  return false
end

Skill = class(function(self, actor, target, func)
    self.actor = actor
    self.target = target
    self:super(func)
  end, Action)