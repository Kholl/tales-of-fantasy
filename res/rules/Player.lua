--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

idle = {
  chk = function()
    return actor:floor()
    and not (actor.cmd.r or actor.cmd.l or actor.cmd.u or actor.cmd.d)
  end,
  cmd = function() actor:start("std") end,
}

wlk = {
  chk = function()
    return actor:floor()
      and not actor.cmd.b1 and not actor.cmd.b2
      and (actor.cmd.r or actor.cmd.l or actor.cmd.u or actor.cmd.d)
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

atk = {
  chk = function() return actor:floor() and actor.cmd.b1 end,
  cmd = function() actor:start("atk") end
}

jmp = {
  chk = function() return actor:floor() and actor.cmd.b2 end,
  cmd = function()
    actor:start("jmp")
    actor:spd().y = actor.prof.jmp
  end
}

atkjmp = {
  chk = function() return actor.cmd.b1 end,
  cmd = function() actor:start("atkjmp") end
}

return {
  std = {wlk, jmp, atk},
  wlk = {wlk, jmp, atk, idle},
  jmp = {atkjmp},
}