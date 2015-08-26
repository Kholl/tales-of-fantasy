--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 35, h = 90}
actor.rad = 20
actor.mass = 1
actor.path = "game/chars/morrigan"

actor.extra = {
  faction = "demon",
  hp = 200, hpmax = 200,
  mp = 300, mpmax = 300,
  dmg = 0,
  rng = 50, rngjmp = 100,
  spd = {x = 100, y = 210, z = 100}, 
}

actor.states = {
  std = {frate = 3, nframes = 13, anim = "loop"},
  wlk = {frate = 0, nframes =  1, anim = "loop"},
  bck = {frate = 0, nframes =  1, anim = "loop", res = "wlk"},
  jmp = {frate = 0, nframes = 5, anim = Anim.Air(-240)},
  blk = {frate = {2,8}, nframes = 2, anim = "play"},
  hit = {frate = 8, nframes = 1, anim = "play"},
  stn = {frate = 0, nframes = 1, anim = "loop"},
  win = {frate = 0, nframes = 1, anim = "loop"},
  atk1 = {frate = {3,3,3,6,4}, nframes = 5, anim = "play"},
  atk2 = {frate = {3,6,4}, nframes = 3, anim = "play"},
  atk3 = {frate = {3,3,3,3,6,4}, nframes = 6, anim = "play"},
  atk4 = {frate = {3,3,6,4}, nframes = 4, anim = "play"},
  atk5 = {frate = {3,3,3,3,6,4}, nframes = 6, anim = "play"},
  atk6 = {frate = {4,4,8}, nframes = 3, anim = "play", pad = {x = 0.5, y = -25}},
  spl1 = {frate = 3, nframes = 2, anim = "loop"},
  spl2 = {frate = 2, nframes = 1, anim = "play"},
  spl3 = {frate = 2, nframes = 3, anim = "loop"},
  stdup = {frate = 4, nframes = 3, anim = "play", pad = {x = 0.5, y = -15}},
  hitair = {frate = 0, nframes = 1, anim = Anim.Air2()},
  hithvy = {frate = 8, nframes = 1, anim = "play"},
  hitflr = {frate = 30, nframes = 1, anim = "play"},
  jmpend = {frate = 4, nframes = 2, anim = "play"},
  jmpbck = {frate = 3, nframes = 7, anim = "play"},
  atkjmp1 = {frate = 4, nframes = 2, anim = "play"},
  atkjmp2 = {frate = 2, nframes = 4, anim = "play"},
}

actor.list = {}
actor.list.auto = EnemyAuto(actor.extra):add{
  blk = {  ActorScript.isEnded / ActorScript.act("std") },
  atk1 = { ActorScript.isFrame(2) / Beat.Script.hitAll(),
           ActorScript.isEnded / ActorScript.act("std") },
  atk2 = { ActorScript.isFrame(1) / Beat.Script.hitAll(),
           ActorScript.isEnded / ActorScript.act("std") },
  atk3 = { ActorScript.isFrame(4) / Beat.Script.hitAll(),
           ActorScript.isEnded / ActorScript.act("std") },
  atk4 = { ActorScript.isFrame(3) / Beat.Script.hitAll(),
           ActorScript.isEnded / ActorScript.act("std") },
  atk5 = { ActorScript.isFrame(2) / Beat.Script.hitAll(),
           ActorScript.isEnded / ActorScript.act("std") },
  atk6 = { ActorScript.isFrame(1) / Beat.Script.hitAll() /
             ActorScript.move{x = 120, y = -240},
           ActorScript.isFrame(2) / Beat.Script.hitAll(),
           ActorScript.isFrame(3) / Beat.Script.hitAll(),
           ActorScript.isFall / ActorScript.act("jmp") },
  spl1 = { ActorScript.isEnded / ActorScript.act("std") },
  spl2 = { ActorScript.isEnded / ActorScript.act("spl3") },
  spl3 = { },
  stdup = { ActorScript.isEnded / ActorScript.act("std") },
  jmpbck = {  ActorScript.isFloor / ActorScript.act("stdup") },
  atkjmp1 = { ActorScript.isFrame(1) / Beat.Script.hitAll(),
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("stdup") },
  atkjmp2 = { ActorScript.isFrame(2) / Beat.Script.hitAll(),
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("stdup") },
}

actor.list.AI = EnemyAI(actor.extra):add{
  std = {
    ActorScript.isTargetState("atk-") ^ Script.isHitTarget / ActorScript.act("blk"),
  },
  
  wlk = {
     ActorScript.isTargetState("atk-") ^ Script.isHitTarget / ActorScript.act("blk"),
  },
  
  bck = {
    ActorScript.isRange("x", 0) / ActorScript.act("jmpbck") / ActorScript.move{x = -200, y = -200},
    ActorScript.isTargetState("atk-") ^ ActorScript.isHitTarget / ActorScript.act("blk"),
  },
}

actor.list.AI:stop()
return actor