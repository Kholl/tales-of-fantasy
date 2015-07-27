--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 28, h = 78}
actor.rad = 14
actor.mass = 1
actor.pmap = Asset["high elf pal"]

actor.info = {
  faction = "helf",
  hp = 300, hpmax = 300,
  mp = 100, mpmax = 100,
  dir = {x = 0, z = 0},
}

actor.states = {
  std = { res = "game/chars/telarin/std.png", dim = {w = 100, h =  80}, frate = 10, nframes = 2, anim = "loop"},
  wlk = { res = "game/chars/telarin/wlk.png", dim = {w = 100, h = 114}, frate =  3, nframes = 8, anim = "loop"},
  bck = { res = "game/chars/telarin/wlk.png", dim = {w = 100, h = 114}, frate =  4, nframes = 8, anim = "looprev"},
  atk1 = { res = "game/chars/telarin/atk1.png", dim = {w = 252, h = 81}, frate = {4,4,4,4,6,4,4}, nframes = 7, anim = "play",
           pad = {x = 100, y = 1}},
  atk2 = { res = "game/chars/telarin/atk2.png", dim = {w = 200, h = 90}, frate = {3,3,6,3}, nframes = 4, anim = "play",
           pad = {x = 0.5, y = -5}},
  jmp = { res = "game/chars/telarin/jmp.png", dim = {w = 106, h = 109}, frate = 0, nframes = 3, anim = Anim.Air3(60)},
  hit = { res = "game/chars/telarin/hit.png", dim = {w = 132, h =  84}, frate = 4, nframes = 2, anim = "play"},
  hitair = { res = "game/chars/telarin/hitair.png", dim = {w = 111, h =  77}, frate = 0, nframes = 2, anim = Anim.Air2()},
  hithvy = { res = "game/chars/telarin/hithvy.png", dim = {w = 158, h = 111}, frate = 2, nframes = 3, anim = "play"},
  hitflr = { res = "game/chars/telarin/hitflr.png", dim = {w = 125, h =  52}, frate = {2,28}, nframes = 2, anim = "play"},
  jmpend = { res = "game/chars/telarin/jmp.png",    dim = {w =  72, h =  88}, frate = 4, nframes = 2, anim = Anim.Air3(60)},
  atkjmp = { res = "game/chars/telarin/atkair.png", dim = {w = 200, h = 122}, frate = 3, nframes = 7, anim = "play"},
}

actor.list = {}
actor.list.auto = ActorDlg.new{
  all = {  ActorScript.isDmg / ActorScript.set("dmg", 0) / ActorScript.act("hit") },
  wlk = {  ActorScript.move{x =  90, z = 90} },
  bck = {  ActorScript.move{x = -60} },
  jmp = {  ActorScript.isFloor / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  atk1 = { ActorScript.isFrame(4) / ActorScript.hitAll{dmg = 20},
           ActorScript.isEnded / ActorScript.act("std") },
  atk2 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 24},
           ActorScript.isEnded / ActorScript.act("std") },
  hitair = {  ActorScript.isFloor / ActorScript.act("hitflr") },
  hithvy = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hitflr = {  ActorScript.isEnded / ActorScript.act("std") },
  jmpend = {  ActorScript.isFloor / ActorScript.act("std") },
  atkjmp = {  ActorScript.isFrame(6) / ActorScript.hitAll{dmg = 24},
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("std") },
}

actor.list.AI = ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, 20) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
    ActorScript.pick{
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
    },
  },
  
  wlk = {
     ActorScript.faceTarget,
     ActorScript.isRange("x", 180, 100) / ActorScript.act("jmp") / ActorScript.move{x = 100, y = -220},
    -ActorScript.isRange("x", nil, 20) / ActorScript.act("std"),
     ActorScript.isRange("x", 10) / ActorScript.act("bck"),
  },
  
  bck = {
    ActorScript.faceTarget,
    ActorScript.isRange("x", nil, 30) / ActorScript.act("std"),
  },
  
  jmp = {
    ActorScript.isTargetHit{"atkjmp"} / ActorScript.act("atkjmp"),
  },
}

return actor