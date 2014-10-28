--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

start = {
  chk = function()
    local noAction = (actor:action() == nil)
    if noAction then return false end
    
    local state = actor.info.state[actor:action()]
    return not state.req.floor or actor:isFloor()
  end
  cmd = function()
    local state = actor.info.state[actor:action()]
    actor:start()
    actor:action(nil)
    
    if state.spd then
      actor:spd{
        x = actor.info.dir.x * (state.spd.x or 0),
        z = actor.info.dir.z * (state.spd.z or 0),
        y = state.spd.y or 0}
    end
  end,
}

restore = function(action) return {
    chk = function()
      return actor:curr():isEnded()
    end,
    cmd = function() actor:start(action or "std") end,
  }
end,

hit = {
  chk = function()
    local state = actor.info.state[actor:state()]
    if not state.hit then return false end    
    if not actor:curr():isFrame(state.hit.frm) then return false end
    
    local box = state.hit.box
    local pos, dim, dir = actor:pos(), actor:dim(), actor:dir()
    local off = scene:off()
    
    local hitbox = {
      x = pos.x + box.x*dir.x + off.x,
      y = pos.y + pos.z - dim.h + box.y + off.y,
      w = box.w * dir.x,
      h = box.h}
    
    vars.hits = scene:getHit(hitbox, function(other)
      return not (actor == other)
        and not (other:state() == "hit")
        and not (other:state() == "hitair")
        and not (other:state() == "hitflr")
    end)
    
    return vars.hits:size() > 0
  end,
  
  cmd = function(vars)
    local state = actor.info.state[actor:state()]
    vars.hits:each(function(i, other)
      local force = state.hit.force
      other:spd{
        x = other:spd().x + actor:dir().x * force.x,
        y = other:spd().y + force.y,
        z = other:spd().z + force.z}
      
      other:start("hit")
      other:face(actor)
    end)
  end}
end

jmpend = {
  chk = function() return actor:floor() end,
  cmd = function() actor:start("std") end,
}

hitair = {
  chk = function() return not actor:floor() end,
  cmd = function() actor:start("hitair") end,
}

hitflr = {
  chk = function() return actor:floor() end,
  cmd = function() actor:start("hitflr") end,
}

wlkend = {
  chk = function() return not actor.prof.action == "wlk" end,
  cmd = function() actor:start("std") end,
}

run = {
  chk = function() return actor:floor() and actor.prof.action == "run" end,
  cmd = function()
    actor:state("run")
    actor:dir().x = actor.prof.dir.x
    
    local state = actor.prof.state.run
    actor:spd{
      x = actor.prof.dir.x * (state.spd.x or 0),
      z = actor.prof.dir.y * (state.spd.z or 0),
      y = state.spd.y or 0}
  end,
}

runend = {
  chk = function() return not actor.prof.action == "run" end,
  cmd = function() actor:start("runend") end,
}

return {
  -- Basic
  std = {wlk, jmp, atk},
  wlk = {wlk, jmp, atk, wlkend},
  run = {runend},
  runend = {restore},
  jmp = {jmpend},
  atk = {atkhit "atk", restore},
  atkjmp = {atkhit "atkjmp", jmpend},
  hit = {hitair, restore},
  hitair = {hitflr},
  hitflr = {restore},
  
  -- Special attack slots
  atk1 = {atkhit "atk1", restore},
  atk2 = {atkhit "atk2", restore},
  atk3 = {atkhit "atk3", restore},
  atk4 = {atkhit "atk4", restore},
  atk5 = {atkhit "atk5", restore},
  atk6 = {atkhit "atk6", restore},
  atk7 = {atkhit "atk7", restore},
  atk8 = {atkhit "atk8", restore},
  atk9 = {atkhit "atk9", restore},
}