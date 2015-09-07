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
  blk = {  isEnded / act("std") },
  atk1 = { isFrame(2) / hit(), isEnded / act("std") },
  atk2 = { isFrame(1) / hit(), isEnded / act("std") },
  atk3 = { isFrame(4) / hit(), isEnded / act("std") },
  atk4 = { isFrame(3) / hit(), isEnded / act("std") },
  atk5 = { isFrame(2) / hit(), isEnded / act("std") },
  atk6 = { isFrame(1) / hit() / move{x = 120, y = -240},
           isFrame(2) / hit(),
           isFrame(3) / hit(),
           isFall / act("jmp") },
  spl1 = { isEnded / act("std") },
  spl2 = { isEnded / act("spl3") },
  spl3 = { },
  stdup =   { isEnded / act("std") },
  jmpbck =  { isFloor / act("stdup") },
  atkjmp1 = { isFrame(1) / hit(), isEnded / act("jmpend"), isFloor / act("stdup") },
  atkjmp2 = { isFrame(2) / hit(), isEnded / act("jmpend"), isFloor / act("stdup") },
}

actor.list.AI = EnemyAI(actor.extra):add{
  std = { isAct("atk-") ^ isHitTarget / act("blk") },  
  wlk = { isAct("atk-") ^ isHitTarget / act("blk") },  
  bck = { isAct("atk-") ^ isHitTarget / act("blk"),
          isRng("x", 0) / {act("jmpbck"), move{x = -200, y = -200}} },
}

actor.list.AI:stop()
return actor