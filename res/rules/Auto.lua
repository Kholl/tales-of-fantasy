--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

notarget = {
  chk = function() return not actor:target() end,
  cmd = function()
    local selectFunc = function(target) return not (actor == target) end
    local sortFunc = function(targetA, targetB) return 1 end
    
    local target = scene:getActors(selectFunc):sort(sortFunc):first()
    if not target then return end
    
    actor:target(target)
  end,
}

target = function(valid) return {
  chk = function() return actor:target() end,
  cmd = function()
    local dist = actor:dist()
    actor.info.dir.x = -Math.Sign(dist.x)
    actor.info.dir.z = -Math.Sign(dist.z)
     
    local sel, best = false, 0
    local actions = valid[actor:state()]
    
    Each(actions, function(action)
      local state = actor.info.state[action]
      if state and Math.InLimOf{"x", "y", "z"}(dist, state.rng) then        
        local val = state.spd and state.spd.x or 1
        if best < val then sel, best = action, val end
      end
    end)

    actor:action(sel)
  end,
} end
      
return {
  all = {
    notarget,
    target{
      std = {
        wlk = true, jmp = true, run = true,
        atk = true, atk2h = true, atkup = true,
      },
      wlk = {wlk = true, jmp = true, run = true},
      run = {run = true, jmp = true, atkrun = true},
      runend = {atkflr = true},
      jmp = {atkjmp = true},
    },
  },
}