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
  
    if actor.cmd.r then actor:sca().x = 1
    elseif actor.cmd.l then actor:sca().x = -1
    end
  end,
}

jmp = {
  chk = function() return actor:floor() and actor.cmd.jmp end,
  cmd = function()
    actor:start("jmp")
    actor:spd().x = actor:face() * actor.prof.spd
    actor:spd().y = actor.prof.jmp
  end
}
  
atk = doWhen("atk", function() return actor:floor() and actor.cmd.atk end)

atkhit = {
  chk = function(vars)
    if not actor:curr():isFrame(actor.prof.hit.frm) then return false end
    
    local box = actor.prof.hit.box
    local pos = actor:pos()
    local dim = actor:dim()
    local face = actor:face()
    local off = scene:off()
    local x, y = pos.x + off.x, pos.y + pos.z + off.y
    local hitbox = {x = x + box.x*face, y = y - dim.h + box.y, w = box.w * face, h = box.h}
    
    vars.hits = scene:getHit(hitbox, function(other)
      return not (actor == other)
        and not (other:state() == "hit")
        and not (other:state() == "hitair")
    end)
    
    return vars.hits:size() > 0
  end,
  
  cmd = function(vars)
    vars.hits:each(function(i, hit)
      hit:spd{
        x = hit:spd().x + actor:face() * actor.prof.hit.force.x,
        y = hit:spd().y + actor.prof.hit.force.y,
        z = hit:spd().z + hit.prof.hit.force.z}
      
      hit:start("hit")
    end)
  end
}

atkend = doWhen("std", function() return actor:curr():isEnded() end)
jmpend = doWhen("std", function() return actor:floor() end)
hitair = doWhen("hitair", function() return not actor:floor() end)
hitend = doWhen("std", function() return Math.Abs(actor:spd().x) < 0.5 end)

return {  
  std = {wlk, jmp, atk},
  wlk = {wlk, jmp, atk, idle},
  jmp = {jmpend},
  atk = {atkhit, atkend},
  hit = {hitair, hitend},
  hitair = {hitair, hitend},
}