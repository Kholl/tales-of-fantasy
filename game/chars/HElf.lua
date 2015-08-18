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
actor.path = "game/chars/delf"

actor.extra = {
  faction = "helf",
  hp = 100, hpmax = 100,
  mp =   0, mpmax =   0,
  dmg = 0,
}

actor.states = {
  std = { frate = 12, nframes = 2, anim = "loop"},
  wlk = { frate =  3, nframes = 8, anim = "loop"},
  bck = { frate =  4, nframes = 8, anim = "looprev", res = "wlk" },
  jmp = { frate =  0, nframes = 1, anim = "idle"},
  hit = { frate =  4, nframes = 2, anim = "play"},
  atk1 = { frate = 3, nframes = 7, anim = "play", pad = {x = 0.5, y = -5} },
  atk2 = { frate = 3, nframes = 4, anim = "play"},
  atk3 = { frate = {3,3,3,6,3,3}, nframes = 6, anim = "play"},
  hitair = { frate =  0, nframes = 2, anim = Anim.Air2()},
  hitflr = { frate = 30, nframes = 1, anim = "play"},
  hitalt = { frate =  4, nframes = 2, anim = "play"},
  jmpend = { frate =  0, nframes = 1, anim = "idle", res = "jmp" },
  atkjmp = { frate = 6, nframes = 3, anim = "play", res = "atkair" },
}

actor.list = {}
actor.list.auto = ActorDlg.new{
  wlk = {  ActorScript.move{x = 100, z = 100} },
  bck = {  ActorScript.move{x = -50} },
  jmp = {  ActorScript.isFloor / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  atk1 = { ActorScript.isFrame(2) / ActorScript.hitAll(Game.dmg(5)),
           ActorScript.isEnded / ActorScript.act("std") },
  atk2 = { ActorScript.isFrame(2) / ActorScript.hitAll(Game.dmg(8, {x = 80})),
           ActorScript.isEnded / ActorScript.act("std") },
  atk3 = { ActorScript.isFrame(2) / ActorScript.hitAll(Game.dmg(10)),
           ActorScript.isEnded / ActorScript.act("std") },
  hitair = {  ActorScript.isFloor / ActorScript.act("hitflr") },
  hithvy = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hitflr = {  ActorScript.isEnded / ActorScript.act("std") },
  jmpend = {  ActorScript.isFloor / ActorScript.act("std") },
  atkjmp = {  ActorScript.isFrame(2) / ActorScript.hitAll(Game.dmg(10)),
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("std") },
  jmpatk = {
    ActorScript.isFrame(2) / ActorScript.hitAll(Game.dmg(10)),
    jmp = ActorScript.isEnded,
    std = SceneScript.isFloor,
  },  
}

actor.list.AI = ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, 60) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
    ActorScript.pick{
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
      ActorScript.isTargetHit{"atk3"} / ActorScript.act("atk3"),
    },
  },
  
  wlk = {
     ActorScript.faceTarget,
     ActorScript.isRange("x", 100, 80) / ActorScript.act("jmp") / ActorScript.move{x = 100, y = -220},
     ActorScript.isRange("x", 60) / ActorScript.act("std"),
     ActorScript.isRange("x", 50) / ActorScript.act("bck"),
  },
  
  bck = {
    ActorScript.faceTarget,
    ActorScript.isRange("x", nil, 80) / ActorScript.act("std"),
  },
  
  jmp = {
    ActorScript.isTargetHit{"atkjmp"} / ActorScript.act("atkjmp"),
  },
}

actor.list.AI:stop()
return actor