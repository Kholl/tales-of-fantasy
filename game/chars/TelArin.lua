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
actor.path = "game/chars/telarin"

actor.extra = {
  faction = "helf",
  hp = 300, hpmax = 300,
  mp = 100, mpmax = 100,
  dmg = 0,
}

actor.states = {
  std = { frate = 10, nframes = 2, anim = "loop"},
  wlk = { frate =  3, nframes = 8, anim = "loop"},
  bck = { frate =  4, nframes = 8, anim = "looprev", res = "wlk"},
  atk1 = { frate = {4,4,4,4,6,4,4}, nframes = 7, anim = "play", pad = {x = 100, y = 1}},
  atk2 = { frate = {3,3,6,3}, nframes = 4, anim = "play", pad = {x = 0.5, y = -5}},
  jmp = { frate = 0, nframes = 3, anim = Anim.Air3(60)},
  hit = { frate = 4, nframes = 2, anim = "play"},
  rdy = { frate = 3, nframes = 5, anim = "play"},
  spl = { frate = 3, nframes = 5, anim = "playrev", res = "rdy"},
  spl1 = { frate = 3, nframes = 3, anim = "play"},
  spl2 = { frate = 3, nframes = 3, anim = "play"},
  spl3 = { frate = 3, nframes = 2, anim = "loop"},
  spl4 = { frate = 4, nframes = 2, anim = "play"},
  spl5 = { frate = 3, nframes = 3, anim = "play"},
  hitair = { frate = 0, nframes = 2, anim = Anim.Air2()},
  hithvy = { frate = 2, nframes = 3, anim = "play"},
  hitflr = { frate = {2,28}, nframes = 2, anim = "play"},
  jmpend = { frate = 4, nframes = 2, anim = Anim.Air3(60), res = "jmp"},
  atkjmp = { frate = 3, nframes = 7, anim = "play", res = "atkair"},
}

actor.list = {}
actor.list.auto = ActorDlg.new{
  wlk = {  ActorScript.move{x =  90, z = 90} },
  bck = {  ActorScript.move{x = -60} },
  jmp = {  ActorScript.isFloor / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  rdy = {  ActorScript.isEnded / ActorScript.act("std") },
  spl = {  },
  spl1 = { },
  spl2 = { ActorScript.isEnded / ActorScript.act("spl3") },
  spl3 = { },
  spl4 = { ActorScript.isEnded / ActorScript.act("rdy") },
  spl5 = { },
  atk1 = { ActorScript.isFrame(4) / ActorScript.hitAll{dmg = 20, force = {x = 140, y = -200}},
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
    ActorScript.isRange("x", nil, 75) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
    ActorScript.pick{
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
    },
  },
  
  wlk = {
     ActorScript.faceTarget,
     ActorScript.isRange("x", 180, 140) / ActorScript.act("jmp") / ActorScript.move{x = 100, y = -220},
     ActorScript.isRange("x", 75) / ActorScript.act("std"),
     ActorScript.isRange("x", 50) / ActorScript.act("bck"),
  },
  
  bck = {
    ActorScript.faceTarget,
    ActorScript.isRange("x", nil, 90) / ActorScript.act("std"),
  },
  
  jmp = {
    ActorScript.isTargetHit{"atkjmp"} / ActorScript.act("atkjmp"),
  },
}

actor.list.AI:stop()
return actor