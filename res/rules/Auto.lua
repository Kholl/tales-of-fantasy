--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--
notarget = {
  chk = function() return not actor:target() end,
  cmd = function()
    local selectFunc = function(target)
      return not (actor == target) and not (actor.info.faction == target.info.faction)
    end

    local sortFunc = function(targetA, targetB)
      return actor:eucl(targetA) < actor:eucl(targetB)
    end

    local target = scene:getActors(selectFunc):sort(sortFunc):first()
    if not target then return end
    
    actor:target(target)
  end,
}

target = function(valid) return {
  chk = function() return actor:target() end,
  cmd = function()
    actor.info.ep = Math.Lim(actor.info.ep +2, {max = actor.info.epmax})
    
    local dist = actor:dist()
    local eucl = actor:eucl()
    
    actor.info.dir.x = -Math.Sign(dist.x)
    actor.info.dir.z = -Math.Sign(dist.z)
     
    local sel, best = false, 0
    local actions = valid[actor:state()]
    
    Each(actions, function(action)
      if action == actor:action() then return end
      
      local state = actor.info.state[action]
      if not state or
         not state.rng or
         not (state.ep <= actor.info.ep) or
         not Math.InLim(eucl, state.rng) then return end
        
      local val = state.spd and state.spd.x or Math.Rand(1, 10)
      if best < val then sel, best = action, val end
    end)
  
    if sel then actor.info.ep = actor.info.ep - actor.info.state[sel].ep end

    actor:face()
    actor:action(sel)
  end,
} end
      
return {
  all = {
    notarget,
    target{
      std = {
        wlk = true, jmp = true, run = true, blk = true,
        atk = true, atkalt = true, atkup = true, atkrnd = true,
      },
      atk = {atksq1 = true},
      atksq1 = {atksq2 = true},
      atksq2 = {atksq3 = true},
      wlk = {wlk = true, jmp = true, run = true},
      run = {run = true, jmp = true, atkrun = true},
      runend = {dodge = true},
      jmp = {atkjmp = true},
      blk = {blk = true},
    },
  },
}