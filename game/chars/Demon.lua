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
  jmp = { frate = 4, nframes = 3, anim = "play"},
  fly = { frate = 0, nframes = 1},
  hit = { frate = 8, nframes = 1, anim = "play"},
  atk1 = { frate = {6,10}, nframes = 2, anim = "play"},
  atk2 = { frate = 4, nframes = 7, anim = "play"},
  atk3 = { frate = {4,4,8}, nframes = 3, anim = "play"},
  atkjmp = { frate = 6, nframes = 4, anim = "play"},
  jmpend = { frate = 0, nframes = 1},
  flyend = { frate = 3, nframes = 2, anim = "play", res = "fly" },
  hitair = { frate = 0, nframes = 2, anim = Anim.Air2()},
  hitflr = { frate = {2,2,26}, nframes = 3, anim = "play"},
}

actor.list = {}
actor.list.auto = EnemyAuto{spd = 100}:add{
  jmp = { ActorScript.isEnded / ActorScript.act("fly") },
  fly = {  ActorScript.move{x = 120, z = 30} ^ ActorScript.spd{y = 20},
           ActorScript.isFloor / ActorScript.act("std") },
  atk1 = { ActorScript.isFrame(1) / ActorScript.hitAll(Game.dmg(8)),
           ActorScript.isEnded / ActorScript.act("std") },
  atk2 = { ActorScript.isFrame(4) / ActorScript.hitAll(Game.dmg(15, {x = 40, y = -200})),
           ActorScript.isEnded / ActorScript.act("std") },
  atk3 = { ActorScript.isFrame(2) / ActorScript.hitAll(Game.dmg(10)),
           ActorScript.isEnded / ActorScript.act("std") },
  atkjmp = { ActorScript.isFrame(3) / ActorScript.hitAll(Game.dmg(12)),
             ActorScript.isFloor / ActorScript.act("std") },
}

actor.list.AI = EnemyAI{spd = 100, rng = 30, rngjmp = 120}:add{
  std = {
    ActorScript.pick{
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
      ActorScript.isTargetHit{"atk3"} / ActorScript.act("atk3"),
    },
  },
  
  wlk = {
    ActorScript.isRange("x", 120, 100) / ActorScript.act("atkjmp") / ActorScript.move{x = 140, y = -180, z = 0},
  },
  
  fly = {
     ActorScript.isRange("x", 60) / ActorScript.act("jmpend"),
  },    
}

actor.list.AI:stop()
return actor