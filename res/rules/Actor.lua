--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

attack = {
  chk = function(vars)
    local state = actor.info.state[actor:state()]
    local hit = state.hit[actor:curr():frame()]
    if not hit then return false end
    
    local box = hit.box
    local pos, dim, dir = actor:pos(), actor:dim(), actor:dir()
    local off = scene:off()
    
    local hitbox = {
      x = pos.x + box.x*dir.x + off.x,
      y = pos.y + pos.z - dim.h + box.y + off.y,
      w = box.w * dir.x,
      h = box.h}
    
    vars.hit = hit
    vars.hits = scene:getHit(hitbox, function(other)
      return not (actor == other)
        and not (other:state() == "hit")
        and not (other:state() == "hitair")
        and not (other:state() == "hitflr")
    end)
    
    return vars.hits:size() > 0
  end,
  
  cmd = function(vars)
    local hit = vars.hit
    vars.hits:each(function(i, other)
      local force = hit.force
      local dist = actor:dist(other)
      local face = {
        x = -Math.Sign(dist.x),
        z = -Math.Sign(dist.z)}
      
      other:spd{
        x = other:spd().x + face.x * (force.x or 0),
        z = other:spd().z + face.z * (force.z or 0),
        y = other:spd().y + (force.y or 0)}
      
      other:start("hit")
      other:target(actor)
      other:face()
    end)
  end,
}

idle = function(action) return {
  chk = function() return actor:action() == false and not (actor:state() == action) end,
  cmd = function() print("IDLE"); actor:start(action) end,
} end

action = function(action) return {
  chk = function() return actor:action() == action end,
  cmd = function()    
    if not (actor:state() == action) then actor:start(action) end
    
    local state = actor.info.state[action]
    if state.spd then
      actor:spd{
        x = actor.info.dir.x * (state.spd.x or 0),
        z = actor.info.dir.z * (state.spd.z or 0),
        y = state.spd.y or 0}
    end
  end,
} end

finish = function(action) return {
  chk = function() return actor:curr():isEnded() end,
  cmd = function() actor:start(action) end,
} end

floor = function(action) return {
  chk = function() return actor:floor() end,
  cmd = function() actor:start(action) end,
} end

nofloor = function(action) return {
  chk = function() return not actor:floor() end,
  cmd = function() actor:start(action) end,
} end

return {
  std = {
    action("wlk"), action("jmp"), action("run"), action("blk"),
    action("atk"), action("atk2h"), action("atkflr"), action("atkup"), action("atkrnd")},
  wlk = {action("wlk"), action("jmp"), idle("std")},
  run = {action("run"), action("jmp"), idle("runend"), action("atkrun")},
  runend = {action("atkflr"), finish("std")},
  blk = {action("blk"), idle("std")},
  atk = {attack, finish("std")},
  jmp = {action("atkjmp"), floor("std")},
  jmprun = {floor("std")},
  hit = {nofloor("hitair"), finish("std")},
  hitair = {floor("hitflr")},
  hitflr = {finish("std")},
  atkjmp = {attack, floor("std")},
  atk2h = {attack, finish("std")},
  atkrun = {attack, finish("std")},
  atkflr = {attack, finish("std")},
  atkup = {attack, finish("jmp")},
  atkrnd = {attack, finish("std")},
}