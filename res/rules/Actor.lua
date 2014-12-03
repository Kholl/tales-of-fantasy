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
      local eucl = actor:eucl{x = 1, y = 1, z = 5}(other)
      
      return not (actor == other)
        and not (actor.info.faction == other.info.faction)
        and not (other:state() == "hit")
        and not (other:state() == "hitair")
        and not (other:state() == "hitflr")
        and not (other:state() == "hitalt")
        and not (other:state() == "hithvy")
        and Math.InLim(eucl, state.rng)
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
      
      other:spd().x = face.x * (force.x or 0)
      other:spd().z = face.z * (force.z or 0)
      
      if other:state() == "blk" and other:facing(actor) then return end
      
      other:spd().y = force.y or 0
      other:target(actor)
      other:face()
      
      local action = Math.Pick{"hit", "hitalt"}
      if other.states[action]
        then other:start(action)
        else other:start("hit")
      end
    end)
  end,
}

idle = function(action) return {
  chk = function() return actor:action() == false and not (actor:state() == action) end,
  cmd = function() actor:start(action) end,
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

chain = function(action) return {
  chk = function() return actor:curr():isEnded() and actor:action() == action end,
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

fall = function(action) return {
  chk = function() return actor:spd().y > 0 end,
  cmd = function() actor:start(action) end,
} end

return {
  std = {
    action("wlk"), action("jmp"), action("run"), action("blk"),
    action("atk"), action("atkalt"), action("atkflr"), action("atkup"), action("atkrnd")},
  wlk = {action("wlk"), action("jmp"), idle("std")},
  run = {action("run"), action("jmp"), idle("runend"), action("atkrun")},
  runend = {action("atkflr"), finish("std")},
  blk = {action("blk"), idle("std")},
  atk = {attack, chain("atksq1"), finish("std")},
  atksq1 = {attack, chain("atksq2"), finish("std")},
  atksq2 = {attack, chain("atksq3"), finish("std")},
  atksq3 = {attack, finish("std")},
  jmp = {action("atkjmp"), floor("std")},
  jmprun = {floor("std")},
  hit = {nofloor("hitair"), finish("std")},
  hitair = {floor("hitflr")},
  hitflr = {finish("std")},
  hitalt = {nofloor("hitair"), finish("std")},
  hithvy = {fall("hitair")},
  atkjmp = {attack, floor("std")},
  atkalt = {attack, finish("std")},
  atkrun = {attack, finish("std")},
  atkflr = {attack, finish("std")},
  atkup = {attack, finish("jmp")},
  atkrnd = {attack, finish("std")},
}