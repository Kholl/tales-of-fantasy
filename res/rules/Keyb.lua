--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

wlk = {
  chk = function()
    actor.info.dir = {x = 0, z = 0}
    
    if actor:isKeyset{"r[dub]*>"} then actor.info.dir.x = 1
    elseif actor:isKeyset{"l[dub]*>"} then actor.info.dir.x = -1
    end
    
    if actor:isKeyset{"[rl]*d[b]*>"} then actor.info.dir.z = 1
    elseif actor:isKeyset{"[rl]*u[b]*>"} then actor.info.dir.z = -1
    end
    
    if not (actor.info.dir.x == 0) then actor:dir().x = actor.info.dir.x end
    if not (actor.info.dir.x == 0) or not (actor.info.dir.z == 0) then
      actor:action("wlk")
    end
  end,
  cmd = function() end
}

run = {
  chk = function()
    if actor:isKeyset{"r>r>"} then
      actor.info.dir.x = 1
      actor:dir().x = actor.info.dir.x      
      actor:action("run")
    elseif actor:isKeyset{"l>l>"} then
      actor.info.dir.x = -1
      actor:dir().x = actor.info.dir.x      
      actor:action("run")
    end
  end,
  cmd = function() end
}

runatk = {
  chk = function()
    if actor:isKeyset{"ra>r>r>", "la>l>l>"} then
      actor:action("atkrun")
    end
  end,
  cmd = function() end,
}

atk = {
  chk = function()
    if actor:isKeyset{"a>"} then
      actor:action("atk")
    end
  end,
  cmd = function() end,
}

jmp = {
  chk = function()
    if actor:isKeyset{"[rlud]*b>"} then
      actor:action("jmp")
    end
  end,
  cmd = function() end,
}

atkjmp = {
  chk = function()
    if actor:isKeyset{"[rlud]*a>"} then
      actor:action("atkjmp")
    end
  end,
  cmd = function() end,
}

atkalt = {
  chk = function()
    if actor:isKeyset{"[rl]a>"} then
      actor:action("atkalt")
    end
  end,
  cmd = function() end,
}

atkup = {
  chk = function()
    if actor:isKeyset{"ua>u>d>"} then      
      actor:action("atkup")
    end
  end,
  cmd = function() end,
}

atkrnd = {
  chk = function()
    if actor:isKeyset{"ab>"} then
      actor:action("atkrnd")
    end
  end,
  cmd = function() end,
}

atksq1 = {
  chk = function()
    if actor:isKeyset{"a>a>"} then
      actor:action("atksq1")
    end
  end,
  cmd = function() end,
}

atksq2 = {
  chk = function()
    if actor:isKeyset{"a>a>a>"} then
      actor:action("atksq2")
    end
  end,
  cmd = function() end,
}

atksq3 = {
  chk = function()
    if actor:isKeyset{"a>a>a>a>"} then
      actor:action("atksq3")
    end
  end,
  cmd = function() end,
}

blk = {
  chk = function()
    if actor:isKeyset{"da>"} then
      actor:action("blk")
    end
  end,
  cmd = function() end,
}

dodge = {
  chk = function()
    if actor:isKeyset{"rd>r>r>", "ld>l>l>"} then
      actor:action("dodge")
    end
  end,
  cmd = function() end
}
    
return {
  std = {atkalt, atkup, wlk, run, atk, jmp, atkrnd, blk},
  wlk = {wlk, run, jmp},
  run = {run, runatk, jmp, dodge},
  jmp = {atkjmp},
  atk = {atksq1},
  atksq1 = {atksq2},
  atksq2 = {atksq3},
  blk = {blk},
}