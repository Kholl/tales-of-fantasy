--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

wlk = {
  chk = function()
    return 
      (actor.info.key[0]["a"] + actor.info.key[0]["b"]) == 0 and
      (actor.info.key[0]["r"] + actor.info.key[0]["l"] + actor.info.key[0]["u"] + actor.info.key[0]["d"]) >= 1
  end,

  cmd = function()
    actor:action("wlk")
    actor.info.dir = {x = 0, z = 0}
    
    if actor.info.key[0]["r"] >= 1 then actor.info.dir.x = 1
    elseif actor.info.key[0]["l"] >= 1 then actor.info.dir.x = -1
    end
    
    if actor.info.key[0]["d"] >= 1 then actor.info.dir.z = 1
    elseif actor.info.key[0]["u"] >= 1 then actor.info.dir.z = -1
    end
  
    if not (actor.info.dir.x == 0) then actor:dir().x = actor.info.dir.x end
  end,
}

run = {
  chk = function()
    return
      actor.info.key[1] and actor.info.key[1]["i"] >= 1 and actor.info.key[1]["i"] <= 10 and
      ((actor.info.key[0]["l"] == 0 and actor.info.key[0]["r"] >= 1 and actor.info.key[1]["l"] == 0 and actor.info.key[1]["r"] >= 1 and actor.info.key[1]["r"] <= 10) or
       (actor.info.key[0]["l"] >= 1 and actor.info.key[0]["r"] == 0 and actor.info.key[1]["l"] >= 1 and actor.info.key[1]["r"] == 0 and actor.info.key[1]["l"] <= 10))
  end,
  
  cmd = function()
    actor:action("run")
    actor.info.dir = {x = 0, z = 0}
    
    if actor.info.key[0]["r"] >= 1 then actor.info.dir.x = 1
    elseif actor.info.key[0]["l"] >= 1 then actor.info.dir.x = -1
    end
    
    if actor.info.key[0]["d"] >= 1 then actor.info.dir.z = 1
    elseif actor.info.key[0]["u"] >= 1 then actor.info.dir.z = -1
    end
  
    if not (actor.info.dir.x == 0) then actor:dir().x = actor.info.dir.x end
  end,
}

blk = {
  chk = function() return actor.info.key[0]["a"] >= 10 and actor.info.key[0]["b"] == 0 end,
  cmd = function() actor:action("blk") end,
}

dodge = {
  chk = function()
    return actor.info.key[1] and
      actor.info.key[0]["u"] == 0 and actor.info.key[0]["d"] >= 1 and
      actor.info.key[1]["u"] == 0 and actor.info.key[1]["i"] >= 1 and actor.info.key[1]["i"] <= 10 and
      actor.info.key[1]["d"] >= 1 and actor.info.key[1]["d"] <= 10
  end,
  cmd = function()
    actor:action("dodge")
    actor.info.dir.x = actor:dir().x
  end
}

atk = {
  chk = function() return actor.info.key[0]["a"] >= 1 and actor.info.key[0]["a"] <= 10 and actor.info.key[0]["b"] == 0 end,
  cmd = function() actor:action("atk") end,
}

atkrun = {
  chk = function() return actor.info.key[0]["a"] >= 1 and actor.info.key[0]["b"] == 0 end,
  cmd = function() actor:action("atkrun") end,
}

jmp = {
  chk = function() return actor.info.key[0]["a"] == 0 and actor.info.key[0]["b"] >= 1 and actor.info.key[0]["b"] <= 10 end,
  cmd = function() actor:action("jmp") end,
}

atkjmp = {
  chk = function() return actor.info.key[0]["a"] >= 1 and actor.info.key[0]["b"] == 0 end,
  cmd = function() actor:action("atkjmp") end,
}

atkalt = {
  chk = function()
    return 
      actor.info.key[0]["a"] >= 1 and actor.info.key[0]["a"] <= 10 and actor.info.key[0]["b"] == 0 and
      ((actor:dir().x ==  1 and actor.info.key[0]["r"] >= 1 and actor.info.key[0]["r"] <= 10) or
       (actor:dir().x == -1 and actor.info.key[0]["l"] >= 1 and actor.info.key[0]["l"] <= 10))
  end,
  cmd = function() actor:action("atkalt") end,
}

atkup = {
  chk = function()
    return actor.info.key[1] and actor.info.key[2] and 
      actor.info.key[0]["a"] >= 1 and actor.info.key[0]["a"] <= 10 and
      actor.info.key[1]["d"] == 0 and actor.info.key[1]["u"] >= 1 and
      actor.info.key[2]["i"] >= 1 and actor.info.key[2]["i"] <= 10 and
      actor.info.key[2]["u"] == 0 and actor.info.key[2]["d"] >= 1 and actor.info.key[2]["d"] <= 10
  end,
  cmd = function()
    actor:action("atkup")
    actor.info.dir.x = actor:dir().x
  end,
}

atkrnd = {
  chk = function()
    return
      actor.info.key[0]["a"] >= 1 and actor.info.key[0]["a"] <= 10 and
      actor.info.key[0]["b"] >= 1 and actor.info.key[0]["b"] <= 10
  end,
  cmd = function() actor:action("atkrnd") end,
}

atksq = function(num) return {
  chk = function() return actor.info.key[0]["a"] >= 1 and actor.info.key[0]["a"] <= 10 and actor.info.key[0]["b"] == 0 end,
  cmd = function() actor:action("atksq" .. num) end,
} end
    
return {
  std = {wlk, jmp, run, blk, atk, atkalt, atkup, atkrnd},
  wlk = {wlk, jmp},
  atk = {atksq("1")},
  atksq1 = {atksq("2")},
  atksq2 = {atksq("3")},
  run = {run, jmp, atkrun},
  runend = {dodge},
  jmp = {atkjmp},
  blk = {blk},
}