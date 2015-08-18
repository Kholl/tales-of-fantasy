--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 32, h = 55}
actor.rad = 22
actor.mass = 2
actor.path = "game/chars/gargoyle"

actor.extra = {
  faction = "demon",
  hp = 75, hpmax = 75,
  mp =  0, mpmax = 0,
  dmg = 0,
}

actor.states = {
  std = { frate = 0, nframes = 1},
  stn = { frate = 0, nframes = 1},
  wlk = { frate = 3, nframes = 6, anim = "loop"},
  bck = { frate = 4, nframes = 6, anim = "looprev", res = "wlk" },
  fly = { frate = 0, nframes = 1},
  hit = { frate = 8, nframes = 1, anim = "play"},
  atk1 = { frate = {6,10}, nframes = 2, anim = "play"},
  atk2 = { frate = 4, nframes = 7, anim = "play"},
  atk3 = { frate = {4,4,8}, nframes = 3, anim = "play"},
  atkjmp = { frate = 6, nframes = 4, anim = "play"},
  flyend = { frate = 3, nframes = 2, anim = "play", res = "fly" },
  hitair = { frate = 0, nframes = 2, anim = Anim.Air2()},
  hitflr = { frate = {2,2,26}, nframes = 3, anim = "play"},
  jmpend = { frate = 0, nframes = 1},
  jmpbck = { frate = 4, nframes = 3, anim = "play"},
}

actor.list = {}
actor.list.auto = ActorDlg.new{
  wlk = {  ActorScript.move{x =  80, z = 80} },
  bck = {  ActorScript.move{x = -40} },
  fly = {  ActorScript.move{x = 120, z = 30} ^ ActorScript.spd{y = 20},
           ActorScript.isFloor / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  atk1 = { ActorScript.isFrame(1) / ActorScript.hitAll(Game.dmg(8)),
           ActorScript.isEnded / ActorScript.act("std") },
  atk2 = { ActorScript.isFrame(4) / ActorScript.hitAll(Game.dmg(15, {x = 40, y = -200})),
           ActorScript.isEnded / ActorScript.act("std") },
  atk3 = { ActorScript.isFrame(2) / ActorScript.hitAll(Game.dmg(10)),
           ActorScript.isEnded / ActorScript.act("std") },
  atkjmp = { ActorScript.isFrame(3) / ActorScript.hitAll(Game.dmg(12)),
             ActorScript.isFloor / ActorScript.act("std") },
  hitair = { ActorScript.isFloor / ActorScript.act("hitflr") },
  hitflr = { ActorScript.isEnded / ActorScript.act("std") },
  jmpend = { ActorScript.isFloor / ActorScript.act("std") },
  jmpbck = { ActorScript.isEnded / ActorScript.act("fly") },
}

actor.list.AI = ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, 30) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
    ActorScript.pick{
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
      ActorScript.isTargetHit{"atk3"} / ActorScript.act("atk3"),
    },
  },
  
  wlk = {
     ActorScript.faceTarget,
     ActorScript.isRange("x", 160, 140) / ActorScript.act("jmpbck") / ActorScript.move{x = -40, y = -200},
     ActorScript.isRange("x", 140, 120) / ActorScript.act("atkjmp") / ActorScript.move{x = 120, y = -200},
     ActorScript.isRange("x", 30) / ActorScript.act("std"),
     ActorScript.isRange("x", 20) / ActorScript.act("bck"),
  },
  
  fly = {
     ActorScript.isRange("x", 60) / ActorScript.act("jmpend"),
  },  
  
  bck = {
    ActorScript.faceTarget,
    ActorScript.isRange("x", nil, 40) / ActorScript.act("std"),
  },
  
  jmp = {
    ActorScript.isTargetHit{"atkjmp"} / ActorScript.act("atkjmp"),
  },
}

actor.list.AI:stop()
return actor