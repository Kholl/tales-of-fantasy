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

actor.extra = {
  faction = "demon",
  hp = 200, hpmax = 200,
  mp = 300, mpmax = 300,
  dmg = 0,
}

actor.states = {
  std = {res = "game/chars/morrigan/std.png", dim = {w =  74, h = 100}, frate = 3, nframes = 13, anim = "loop"},
  wlk = {res = "game/chars/morrigan/wlk.png", dim = {w =  57, h = 108}, frate = 0, nframes = 1, anim = "loop"},
  bck = {res = "game/chars/morrigan/wlk.png", dim = {w =  57, h = 108}, frate = 0, nframes = 1, anim = "loop"},
  jmp = {res = "game/chars/morrigan/jmp.png", dim = {w =  72, h =  88}, frate = 0, nframes = 5, anim = Anim.Air(-240)},
  blk = {res = "game/chars/morrigan/blk.png", dim = {w = 178, h = 113}, frate = {2,8}, nframes = 2, anim = "play"},
  hit = {res = "game/chars/morrigan/hit.png", dim = {w =  78, h =  91}, frate = 8, nframes = 1, anim = "play"},
  stn = {res = "game/chars/morrigan/stn.png", dim = {w =  74, h =  78}, frate = 0, nframes = 1, anim = "loop"},
  win = {res = "game/chars/morrigan/win.png", dim = {w =  64, h = 111}, frate = 0, nframes = 1, anim = "loop"},
  atk1 = {res = "game/chars/morrigan/atk1.png", dim = {w = 200, h =  89}, frate = {3,3,3,6,4}, nframes = 5, anim = "play"},
  atk2 = {res = "game/chars/morrigan/atk2.png", dim = {w = 120, h =  99}, frate = {3,6,4}, nframes = 3, anim = "play"},
  atk3 = {res = "game/chars/morrigan/atk3.png", dim = {w = 200, h = 114}, frate = {3,3,3,3,6,4}, nframes = 6, anim = "play"},
  atk4 = {res = "game/chars/morrigan/atk4.png", dim = {w = 220, h = 105}, frate = {3,3,6,4}, nframes = 4, anim = "play"},
  atk5 = {res = "game/chars/morrigan/atk5.png", dim = {w = 192, h = 126}, frate = {3,3,3,3,6,4}, nframes = 6, anim = "play"},
  atk6 = {res = "game/chars/morrigan/atk6.png", dim = {w =  76, h = 140}, frate = {4,4,8}, nframes = 3, anim = "play",
          pad = {x = 0.5, y = -25}},
  spl1 = {res = "game/chars/morrigan/spl1.png", dim = {w = 104, h =  86}, frate = 3, nframes = 2, anim = "loop"},
  spl2 = {res = "game/chars/morrigan/spl2.png", dim = {w =  55, h = 123}, frate = 3, nframes = 4, anim = "loop"},
  stdup = {res = "game/chars/morrigan/stdup.png", dim = {w = 84, h = 99}, frate = 4, nframes = 3, anim = "play",
           pad = {x = 0.5, y = -15}},
  hitair = {res = "game/chars/morrigan/hitair.png", dim = {w = 115, h =  87}, frate = 0, nframes = 1, anim = Anim.Air2()},
  hithvy = {res = "game/chars/morrigan/hithvy.png", dim = {w =  74, h =  97}, frate = 8, nframes = 1, anim = "play"},
  hitflr = {res = "game/chars/morrigan/hitflr.png", dim = {w = 141, h =  33}, frate = 30, nframes = 1, anim = "play"},
  jmpend = {res = "game/chars/morrigan/jmpend.png", dim = {w =  72, h =  88}, frate = 4, nframes = 2, anim = "play"},
  jmpbck = {res = "game/chars/morrigan/jmpbck.png", dim = {w = 190, h = 160}, frate = 3, nframes = 7, anim = "play"},
  atkjmp1 = {res = "game/chars/morrigan/atkjmp1.png", dim = {w = 158, h =  88}, frate = 4, nframes = 2, anim = "play"},
  atkjmp2 = {res = "game/chars/morrigan/atkjmp2.png", dim = {w = 216, h =  76}, frate = 2, nframes = 4, anim = "play"},
}

actor.list = {}
actor.list.auto = ActorDlg.new{
  all = {  ActorScript.isExtraGT("dmg", 0) / ActorScript.setExtra("dmg", 0) / ActorScript.act("hit") },
  wlk = {  ActorScript.move{x =  100, z = 100} },
  bck = {  ActorScript.move{x = -100} },
  jmp = {  ActorScript.isFloor / ActorScript.act("stdup") },
  blk = {  ActorScript.isEnded / ActorScript.act("std") },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  stn = {},
  win = {},  
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
  spl2 = { ActorScript.isEnded / ActorScript.act("std") },
  stdup = { ActorScript.isEnded / ActorScript.act("std") },
  hitalt = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hitair = {  ActorScript.isFloor / ActorScript.act("hitflr") },
  hithvy = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hitflr = {  ActorScript.isEnded / ActorScript.act("stdup") },
  jmpend = {  ActorScript.isFloor / ActorScript.act("stdup") },
  jmpbck = {  ActorScript.isFloor / ActorScript.act("stdup") },
  atkjmp1 = { ActorScript.isFrame(1) / ActorScript.hitAll{dmg = 15},
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("stdup") },
  atkjmp2 = { ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 20},
              ActorScript.isEnded / ActorScript.act("jmpend"),
              ActorScript.isFloor / ActorScript.act("stdup") },
}

actor.list.AI = ActorDlg.new{
  std = {
    ActorScript.isRange("x", nil, 20) / ActorScript.act("wlk"),
    ActorScript.isRange("x", 0) ^ Script.random(6) / ActorScript.act("jmpbck") / ActorScript.move{x = -200, y = -200},
    ActorScript.isRange("x", 0) / ActorScript.act("bck"),
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
     ActorScript.faceTarget,
     ActorScript.isRange("x", 180, 100) / ActorScript.act("jmp") / ActorScript.move{x = 100, y = -240},
    -ActorScript.isRange("x", nil, 20) / ActorScript.act("std"),
     ActorScript.isRange("x", 10) / ActorScript.act("bck"),
     ActorScript.isTargetState("atk-") ^ ActorScript.isHitTarget / ActorScript.act("blk"),
  },
  
  bck = {
    ActorScript.faceTarget,
    ActorScript.isRange("x", nil, 80) / ActorScript.act("std"),
    ActorScript.isTargetState("atk-") ^ ActorScript.isHitTarget / ActorScript.act("blk") },
  
  jmp = {
    Script.random(6) ^ ActorScript.pick{
      ActorScript.isTargetHit{"atkjmp1"} / ActorScript.act("atkjmp1"),
      ActorScript.isTargetHit{"atkjmp2"} / ActorScript.act("atkjmp2"),
    },
  },
}

return actor