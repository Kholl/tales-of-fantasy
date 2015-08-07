--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 24, h = 76}
actor.rad = 12
actor.pmap = Asset["high elf pal"]

actor.extra = {
  faction = "helf",
  hp = 100, hpmax = 100,
  mp =   0, mpmax =   0,
  dmg = 0,
}

actor.states = {
  std = { res = "game/chars/delf/std.png", dim = {w = 120, h = 72}, frate = 12, nframes = 2, anim = "loop"},
  wlk = { res = "game/chars/delf/wlk.png", dim = {w =  64, h = 62}, frate =  3, nframes = 8, anim = "loop"},
  bck = { res = "game/chars/delf/wlk.png", dim = {w =  64, h = 62}, frate =  4, nframes = 8, anim = "looprev"},
  jmp = { res = "game/chars/delf/jmp.png", dim = {w =  47, h = 74}, frate =  0, nframes = 1, anim = "idle"},
  hit = { res = "game/chars/delf/hit.png", dim = {w =  60, h = 68}, frate =  4, nframes = 2, anim = "play"},
  atk1 = { res = "game/chars/delf/atk1.png", dim = {w = 154, h = 89}, frate = 3, nframes = 7, anim = "play",
          pad = {x = 0.5, y = -5} },
  atk2 = { res = "game/chars/delf/atk2.png", dim = {w = 188, h = 81}, frate = 3, nframes = 4, anim = "play"},
  atk3 = { res = "game/chars/delf/atk3.png", dim = {w = 211, h = 66}, frate = {3,3,3,6}, nframes = 4,
           anim = "play"},
  hitair = { res = "game/chars/delf/hitair.png", dim = {w =  81, h = 42}, frate =  0, nframes = 2, anim = Anim.Air2()},
  hitflr = { res = "game/chars/delf/hitflr.png", dim = {w =  88, h = 22}, frate = 30, nframes = 1, anim = "play"},
  hitalt = { res = "game/chars/delf/hitalt.png", dim = {w = 100, h = 75}, frate =  4, nframes = 2, anim = "play"},
  jmpend = { res = "game/chars/delf/jmp.png", dim = {w =  47, h = 74}, frate =  0, nframes = 1, anim = "idle"},
  atkjmp = { res = "game/chars/delf/atkair.png", dim = {w = 121, h = 79}, frate = 6, nframes = 3, anim = "play"},
}

actor.list = {}
actor.list.auto = ActorDlg.new{
  {  ActorScript.isExtraGT("dmg", 0) / ActorScript.setExtra("dmg", 0) / ActorScript.act("hit") },
  wlk = {  ActorScript.move{x = 100, z = 100} },
  bck = {  ActorScript.move{x = -60} },
  jmp = {  ActorScript.isFloor / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  atk1 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 5},
           ActorScript.isEnded / ActorScript.act("std") },
  atk2 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 8, force = {x = 80}},
           ActorScript.isEnded / ActorScript.act("std") },
  atk3 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 10},
           ActorScript.isEnded / ActorScript.act("std") },
  hitair = {  ActorScript.isFloor / ActorScript.act("hitflr") },
  hithvy = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hitflr = {  ActorScript.isEnded / ActorScript.act("std") },
  jmpend = {  ActorScript.isFloor / ActorScript.act("std") },
  atkjmp = {  ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 10},
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("std") },
  jmpatk = {
    ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 10},
    jmp = ActorScript.isEnded,
    std = SceneScript.isFloor,
  },  
}

actor.list.AI = ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, 20) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
    ActorScript.pick{
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
      ActorScript.isTargetHit{"atk3"} / ActorScript.act("atk3"),
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

actor.list.AI:stop()
return actor