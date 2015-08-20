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
actor.list.auto = EnemyAuto{spd = 100}:add{
  blk = {  ActorScript.isEnded / ActorScript.act("std") },
  atk1 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 15},
           ActorScript.isEnded / ActorScript.act("std") },
  atk2 = { ActorScript.isFrame(1) / ActorScript.hitAll{dmg = 15},
           ActorScript.isEnded / ActorScript.act("std") },
  atk3 = { ActorScript.isFrame(4) / ActorScript.hitAll{dmg = 30, force = {x = 100, y = -180}},
           ActorScript.isEnded / ActorScript.act("std") },
  atk4 = { ActorScript.isFrame(3) / ActorScript.hitAll{dmg = 20},
           ActorScript.isEnded / ActorScript.act("std") },
  atk5 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 35, force = {x = 40, y = -300}},
           ActorScript.isEnded / ActorScript.act("std") },
  atk6 = { ActorScript.isFrame(1) / ActorScript.hitAll{dmg = 10, force = {x = 140, y = -260}},
           ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 10} / ActorScript.move{x = 120, y = -240},
           ActorScript.isFrame(3) / ActorScript.hitAll{dmg = 10},
           ActorScript.isFall / ActorScript.act("jmp") },
  spl1 = { ActorScript.isEnded / ActorScript.act("std") },
  spl2 = { ActorScript.isEnded / ActorScript.act("spl3") },
  spl3 = { },
  stdup = { ActorScript.isEnded / ActorScript.act("std") },
  jmpbck = {  ActorScript.isFloor / ActorScript.act("stdup") },
  atkjmp1 = { ActorScript.isFrame(1) / ActorScript.hitAll{dmg = 15},
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("stdup") },
  atkjmp2 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 20},
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("stdup") },
}

actor.list.AI = EnemyAI{spd = 100, rng = 50, rngjmp = 100}:add{
  std = {
    ActorScript.isRange("x", 0) / ActorScript.act("jmpbck") / ActorScript.move{x = -200, y = -200},
    ActorScript.isTargetState("atk-") ^ ActorScript.isHitTarget / ActorScript.act("blk"),
    ActorScript.pick{
      ActorScript.isTargetHit{"atk1"} / ActorScript.act("atk1"),
      ActorScript.isTargetHit{"atk2"} / ActorScript.act("atk2"),
      ActorScript.isTargetHit{"atk3"} / ActorScript.act("atk3"),
      ActorScript.isTargetHit{"atk4"} / ActorScript.act("atk4"),
      ActorScript.isTargetHit{"atk5"} / ActorScript.act("atk5"),
      ActorScript.isTargetHit{"atk6"} / ActorScript.act("atk6"),
    },
  },
  
  wlk = {
     ActorScript.isTargetState("atk-") ^ ActorScript.isHitTarget / ActorScript.act("blk"),
  },
  
  bck = {
    ActorScript.isTargetState("atk-") ^ ActorScript.isHitTarget / ActorScript.act("blk") },
  
  jmp = {
    ActorScript.pick{
      ActorScript.isTargetHit{"atkjmp1"} / ActorScript.act("atkjmp1"),
      ActorScript.isTargetHit{"atkjmp2"} / ActorScript.act("atkjmp2"),
    },
  },
}

actor.list.AI:stop()
return actor