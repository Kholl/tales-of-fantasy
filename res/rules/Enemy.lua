--[[
Tales Of Fantasy
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

target = {
  chk = function()
    local state = actor:state()
    local required = actor.prof.state[state] and actor.prof.state[state].req
    return actor:target() and actor:floor() and (not required or required[state])
  end,
  cmd = function()
    actor:face()
    
    local sel = nil
    local dist = actor:dist()
    Each(actor.prof.state, function(action, state)
      if Math.InLimOf{"x", "y", "z"}(dist, state.rng) then sel = action end
    end)

    local state = actor.prof.state[sel or "std"]
    if state and state.spd then
      actor:spd{
        x = actor:dir().x * (state.spd.x or 0),
        z = Math.Sign(dist.z) * (state.spd.z or 0),
        y = (state.spd.y or 0)}
    end
    
    if not (actor:state() == sel) then actor:start(sel) end
  end,
}
      
return {all = {notarget, target}}