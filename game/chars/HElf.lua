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
  rad = 12, rng = 60, rngjmp = 80,
  spd = {x = 100, y = 210, z = 100},
}

actor.states = {
  std = { frate = 12, nframes = 2, anim = "loop"},
  wlk = { frate =  3, nframes = 8, anim = "loop"},
  bck = { frate =  4, nframes = 8, anim = "looprev", res = "wlk" },
  jmp = { frate =  0, nframes = 1, anim = "idle"},
  hit = { frate =  {5,10}, nframes = 2},
  die = { frate =  0, nframes = 1, res = "hitflr" },
  atk1 = { frate = 3, nframes = 7, pad = {x = 0.5, y = -5} },
  atk2 = { frate = 3, nframes = 4},
  atk3 = { frate = {3,3,3,6,3,3}, nframes = 6},
  stdup = { frate = 0, nframes = 2, res = "std"},
  hitair = { frate =  0, nframes = 2, anim = Anim.Air2()},
  hitflr = { frate = 30, nframes = 1},
  hitalt = { frate =  4, nframes = 2},
  jmpend = { frate =  0, nframes = 1, anim = "idle", res = "jmp" },
  atkjmp = { frate = 6, nframes = 3, res = "atkair" },
}

actor.list = {}
actor.list.auto = EnemyAuto(actor.extra):add{
  atk1 =   { isFrame(2) / hit{dmg = 5}, isEnded / act("std") },
  atk2 =   { isFrame(2) / hit{dmg = 5}, isEnded / act("std") },
  atk3 =   { isFrame(2) / hit{dmg = 5}, isEnded / act("std") },
  atkjmp = { isFrame(2) / hit{dmg = 5, hvy = {x = 1, y = 0}}, isEnded / act("jmpend"), isFloor / act("std") },
}

actor.list.AI = EnemyAI(actor.extra)
actor.list.AI:stop()

return actor