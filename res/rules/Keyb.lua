--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

wlk = {
  chk = function()
    return 
      (actor.info.key.b1 + actor.info.key.b2) == 0 and
      (actor.info.key.r + actor.info.key.l + actor.info.key.u + actor.info.key.d) >= 1
  end,

  cmd = function()
    actor:action("wlk")
    actor.info.dir = {x = 0, z = 0}
    
    if actor.info.key.r >= 1 then actor.info.dir.x = 1
    elseif actor.info.key.l >= 1 then actor.info.dir.x = -1
    end
    
    if actor.info.key.d >= 1 then actor.info.dir.z = 1
    elseif actor.info.key.u >= 1 then actor.info.dir.z = -1
    end
  end,
}

run = {
  chk = function()
    local curr = actor.info.key
    local last = actor.info.keyseq[1]
    return last and last.idle >= 1 and last.idle <= 10 and
      ((curr.l == 0 and curr.r >= 1 and last.l == 0 and last.r >= 1 and last.r <= 10) or
       (curr.l >= 1 and curr.r == 0 and last.l >= 1 and last.r == 0 and last.l <= 10))
  end,
  
  cmd = function()
    print("Running")
    actor:action("run")
    actor.info.dir = {x = 0, z = 0}
    
    if actor.info.key.r >= 1 then actor.info.dir.x = 1
    elseif actor.info.key.l >= 1 then actor.info.dir.x = -1
    end
    
    if actor.info.key.d >= 1 then actor.info.dir.z = 1
    elseif actor.info.key.u >= 1 then actor.info.dir.z = -1
    end
  end,
}

atk = {
  chk = function() return actor.info.key.b1 >= 1 and actor.info.key.b1 <= 10 and actor.info.key.b2 == 0 end,
  cmd = function() actor:action("atk") end,
}

atkrun = {
  chk = function() return actor.info.key.b1 >= 1 and actor.info.key.b2 == 0 end,
  cmd = function() actor:action("atkrun") end,
}

jmp = {
  chk = function() return actor.info.key.b1 == 0 and actor.info.key.b2 >= 1 and actor.info.key.b2 <= 10 end,
  cmd = function() actor:action("jmp") end,
}

atkjmp = {
  chk = function() return actor.info.key.b1 >= 1 and actor.info.key.b2 == 0 end,
  cmd = function() actor:action("atkjmp") end,
}

atk2h = {
  chk = function()
    return 
      actor.info.key.b1 >= 1 and actor.info.key.b1 <= 10 and actor.info.key.b2 == 0 and
      ((actor:dir().x ==  1 and actor.info.key.r >= 1 and actor.info.key.r <= 10) or
       (actor:dir().x == -1 and actor.info.key.l >= 1 and actor.info.key.l <= 10))
  end,
  cmd = function() actor:action("atk2h") end,
}

return {
  std = {wlk, atk, atk2h, jmp, run},
  wlk = {wlk, jmp},
  run = {run, jmp, atkrun},
  jmp = {atkjmp},
}