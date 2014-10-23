--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

wlk = {
  chk = function()
    local wlk = 
      (actor.prof.key.b1 + actor.prof.key.b2) == 0 and
      (actor.prof.key.r + actor.prof.key.l + actor.prof.key.u + actor.prof.key.d) >= 1
      
    if actor:state() == "wlk" and not wlk then actor:start("std") end
    return actor:floor() and wlk
  end,

  cmd = function()
    actor:state("wlk")
    
    if actor.prof.key.r >= 1 then actor:spd().x = actor.prof.spd
    elseif actor.prof.key.l >= 1 then actor:spd().x = -actor.prof.spd
    end
    
    if actor.prof.key.d >= 1 then actor:spd().z = actor.prof.spd
    elseif actor.prof.key.u >= 1 then actor:spd().z = -actor.prof.spd
    end
  
    if actor.prof.key.r >= 1 then actor:dir().x = 1
    elseif actor.prof.key.l >= 1 then actor:dir().x = -1
    end
  end,
}

atk = {
  chk = function()
    return actor:floor() and
      actor.prof.key.b1 >= 1 and actor.prof.key.b1 <= 10 and actor.prof.key.b2 == 0
  end,
  cmd = function() actor:start("atk") end
}

jmp = {
  chk = function()
    return actor:floor() and
      actor.prof.key.b1 == 0 and actor.prof.key.b2 >= 1 and actor.prof.key.b2 <= 10
  end,
  cmd = function()
    actor:start("jmp")
    actor:spd().y = actor.prof.jmp
  end
}

atkjmp = {
  chk = function() return actor.prof.key.b1 >= 1 end,
  cmd = function() actor:start("atkjmp") end
}

return {
  std = {wlk, jmp, atk},
  wlk = {wlk, jmp, atk},
  jmp = {atkjmp},
}