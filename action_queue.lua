ActionQueue = class(function(self) 
    self.queue = {}
  end)

function ActionQueue:next_action(sim)
  local block = false
  local ret = nil
  local next_idx
  for idx,action in ipairs(self.queue) do
    if action:is_ready(sim) then
      next_idx = idx
      ret = action
      break
    elseif action:should_block() then
      block = true
    end
  end

  if ret ~= null then
    table.remove(self.queue, next_idx)
  end
  return ret, block
end

function ActionQueue:enqueue(action)
  table.insert(self.queue, action)
  return
end

function ActionQueue:insert_at_front(action)
  table.insert(self.queue, 1, action)
  return
end