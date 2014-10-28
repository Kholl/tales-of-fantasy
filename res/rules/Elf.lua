--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

run = {
  chk = function(vars)
    local curr = actor.prof.key
    local last = actor.prof.keyseq[1]
    local run = last and last.idle >= 1 and last.idle <= 10 and
      ((curr.l == 0 and curr.r >= 1 and last.l == 0 and last.r >= 1 and last.r <= 10) or
       (curr.l >= 1 and curr.r == 0 and last.l >= 1 and last.r == 0 and last.l <= 10))
 
    if actor:state() == "run" and not run then actor:start("runend") end
    return actor:floor() and run
  end,
  cmd = function(vars)
    actor:state("run")
    
    if actor.prof.key.r >= 1 then actor:spd().x = actor.prof.state.run.spd.x
    elseif actor.prof.key.l >= 1 then actor:spd().x = -actor.prof.state.run.spd.x
    end
    
    if actor.prof.key.d >= 1 then actor:spd().z = actor.prof.state.run.spd.z
    elseif actor.prof.key.u >= 1 then actor:spd().z = -actor.prof.state.run.spd.z
    end
  
    if actor.prof.key.r >= 1 then actor:dir().x = 1
    elseif actor.prof.key.l >= 1 then actor:dir().x = -1
    end
  end,
}

runjmp = {
  chk = function() return actor.prof.key.b2 >= 1 end,
  cmd = function()
    actor:start("jmp")
    actor:spd().y = actor.prof.state.jmp.spd.y
  end,
}

runstd = {
  chk = function() return actor:curr():isEnded() end,
  cmd = function() actor:start("std") end,
}

atk1 = {
  chk = function()
    return actor:floor() and
      actor.prof.key.b1 >= 1 and actor.prof.key.b1 <= 10 and actor.prof.key.b2 == 0 and
      ((actor:dir().x ==  1 and actor.prof.key.r >= 1 and actor.prof.key.r <= 10) or
       (actor:dir().x == -1 and actor.prof.key.l >= 1 and actor.prof.key.l <= 10))
  end,
  cmd = function() actor:start("atk1") end,
}

atkend = {
  chk = function() return actor:curr():isEnded() end,
  cmd = function() actor:start("std") end,
}

atk2 = {
  chk = function() return actor.prof.key.b1 >= 1 end,
  cmd = function() actor:start("atk2") end,
}

return {
  std = {atk1, run},
  run = {atk2, run, runjmp},
  runend = {runstd},
  atk1 = {atkend},
  atk2 = {atkend},
}