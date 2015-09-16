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
  rng = 75, rngjmp = 90,
  spd = {x = 90, y = 180, z = 90},
}

actor.states = {
  std =   { frate = 10, nframes = 2, anim = "loop"},
  stdup = { frate =  0, nframes = 2, res = "std"},
  wlk = { frate =  3, nframes = 8, anim = "loop"},
  bck = { frate =  4, nframes = 8, anim = "looprev", res = "wlk"},
  atk1 = { frate = {4,4,4,4,6,4,4}, nframes = 7, pad = {x = 100, y = 1}},
  atk2 = { frate = {3,3,6,3}, nframes = 4, pad = {x = 0.5, y = -5}},
  jmp = { frate = 0, nframes = 3, anim = Anim.Air3(60)},
  hit = { frate = 4, nframes = 2},
  rdy = { frate = 3, nframes = 5},
  die = { frate = 0, nframes = 1},
  spl = { frate = 3, nframes = 5, anim = "playrev", res = "rdy"},
  spl1 = { frate = 3, nframes = 3},
  spl2 = { frate = 3, nframes = 3},
  spl3 = { frate = 3, nframes = 2, anim = "loop"},
  spl4 = { frate = 4, nframes = 2},
  spl5 = { frate = 3, nframes = 3},
  hitair = { frate = 0, nframes = 2, anim = Anim.Air2()},
  hithvy = { frate = 2, nframes = 3},
  hitflr = { frate = {2,28}, nframes = 2},
  jmpend = { frate = 4, nframes = 3, anim = Anim.Air3(60), res = "jmp"},
  atkjmp = { frate = {2,2,2,2,3,3,3}, nframes = 7, res = "atkair"},
}

actor.list = {}
actor.list.auto = EnemyAuto(actor.extra):add{
  rdy = { isEnded / act("std") },
  spl = { },
  spl1 = { },
  spl2 = { isEnded / act("spl3") },
  spl3 = { },
  spl4 = { isEnded / act("rdy") },
  spl5 = { },
  atk1 =   { isFrame(4) / hit(), isEnded / act("std") },
  atk2 =   { isFrame(2) / hit(), isEnded / act("std") },
  atkjmp = { isFrame(6) / hit(), isEnded / act("jmpend"), isFloor / act("std") },
}

actor.list.AI = EnemyAI(actor.extra)
actor.list.AI:stop()

return actor