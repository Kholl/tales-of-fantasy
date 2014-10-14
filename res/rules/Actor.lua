--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

function doWhen(state, chk)
  return {chk = chk, cmd = function() actor:start(state) end}
end

idle = doWhen("std", function() return actor:floor() and actor.cmd.idle end)

wlk = {
  chk = function()
    return actor:floor() and
      (actor.cmd.r or actor.cmd.l or actor.cmd.u or actor.cmd.d)
  end,

  cmd = function()
    actor:state("wlk")
    
    if actor.cmd.r then actor:spd().x = actor.prof.spd
    elseif actor.cmd.l then actor:spd().x = -actor.prof.spd
    end
    
    if actor.cmd.d then actor:spd().z = actor.prof.spd
    elseif actor.cmd.u then actor:spd().z = -actor.prof.spd
    end
  
    if actor.cmd.r then actor:dir().x = 1
    elseif actor.cmd.l then actor:dir().x = -1
    end
  end,
}

jmp = {
  chk = function() return actor:floor() and actor.cmd.jmp end,
  cmd = function()
    actor:start("jmp")
    actor:spd().x = actor:dir().x * actor.prof.spd
    actor:spd().y = actor.prof.jmp
  end
}
  
atk = doWhen("atk", function() return actor:floor() and actor.cmd.atk end)

atkhit = {
  chk = function(vars)
    if not actor:curr():isFrame(actor.prof.hit.frm) then return false end
    
    local box = actor.prof.hit.box
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
    end)
    
    return vars.hits:size() > 0
  end,
  
  cmd = function(vars)
    vars.hits:each(function(i, other)
      other:spd{
        x = other:spd().x + actor:dir().x * actor.prof.hit.force.x,
        y = other:spd().y + actor.prof.hit.force.y,
        z = other:spd().z + actor.prof.hit.force.z}
      
      other:start("hit")
      other:face(actor)
    end)
  end
}

atkend = doWhen("std", function() return actor:curr():isEnded() end)
jmpend = doWhen("std", function() return actor:floor() end)
hitair = doWhen("hitair", function() return not actor:floor() end)
hitflr = doWhen("hitflr", function() return actor:floor() end)
hitend = doWhen("std", function() return actor:curr():isEnded() end)

return {  
  std = {wlk, jmp, atk},
  wlk = {wlk, jmp, atk, idle},
  jmp = {jmpend},
  atk = {atkhit, atkend},
  hit = {hitair, hitend},
  hitair = {hitflr},
  hitflr = {hitend},
}