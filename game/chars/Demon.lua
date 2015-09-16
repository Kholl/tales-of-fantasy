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
  rng = 30, rngjmp = 120,
  spd = {x = 100, y = 210, z = 100},
}

actor.states = {
  std =   { frate = 0, nframes = 1},
  stdup = { frate = 2, nframes = 3, anim = "playrev", res = "hitflr"},
  stn = { frate = 0, nframes = 1},
  wlk = { frate = 3, nframes = 6, anim = "loop"},
  bck = { frate = 4, nframes = 6, anim = "looprev", res = "wlk" },
  jmp = { frate = 4, nframes = 3},
  fly = { frate = 0, nframes = 1},
  hit = { frate = 8, nframes = 1},
  die = { frate = 0, nframes = 1},
  atk1 = { frate = {6,10}, nframes = 2},
  atk2 = { frate = 4, nframes = 7},
  atk3 = { frate = {4,4,8}, nframes = 3},
  atkjmp = { frate = 6, nframes = 4},
  jmpend = { frate = 0, nframes = 1},
  flyend = { frate = 3, nframes = 2, res = "fly" },
  hitair = { frate = 0, nframes = 2, anim = Anim.Air2()},
  hitflr = { frate = {2,2,26}, nframes = 3},
}

actor.list = {}
actor.list.auto = EnemyAuto(actor.extra):add{
  jmp =    { isEnded / act("fly") },
  fly =    { move{x = 120, z = 30} ^ prop("spd"){y = 20}, isFloor / act("std") },
  atk1 =   { isFrame(1) / hit(), isEnded / act("std") },
  atk2 =   { isFrame(4) / hit(), isEnded / act("std") },
  atk3 =   { isFrame(2) / hit(), isEnded / act("std") },
  atkjmp = { isFrame(3) / hit(), isFloor / act("std") },
}

actor.list.AI = EnemyAI(actor.extra):add{
  wlk = { isRng("x", 120, 100) / act("atkjmp") / move{x = 140, y = -180, z = 0} },
  fly = { isRng("x", 60)       / act("jmpend") },    
}

actor.list.AI:stop()
return actor