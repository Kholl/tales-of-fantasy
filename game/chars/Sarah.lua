--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 24, h = 68}
actor.rad = 12
actor.path = "game/chars/lucia"

actor.extra = {
  faction = "helf",
  hp =  75, hpmax =  75,
  mp = 125, mpmax = 125,
  dmg = 0,
  spd = {x = 100, y = -100, z = 100},
}

actor.states = {
  std = { frate = 8, nframes =  3, anim = "loop"},
  wlk = { frate = 2, nframes = 12, anim = "loop"},
  atk = { frate = {2,2,2,2,2,2,6,4}, nframes = 8, anim = "play"},
  jmp = { frate = 0, nframes =  8, anim = Anim.Air(-220)},
  run = { frate = 2, nframes = 12, anim = "loop"},
  hit = { frate = {3,5}, nframes =  2, anim = "play"},
  die = { frate = 0, nframes = 1, anim = "play", res = "hitflr"},
  blk = { frate = 2, nframes = 1, anim = "idle"},
  atkup = { frate = 4, nframes = 4, anim = "play"},
  jmpatk = { frate = {2,2,2,2,2,6,4}, nframes = 7, anim = "play"},
  runend = { frate = {2,2,8}, nframes = 3, anim = "play"},
  runatk = { frate = {2,2,2,4,8}, nframes = 5, anim = "play"},
  atkalt = { frate = {2,2,2,2,2,2,2,4,8}, nframes = 9, anim = "play", pad = {x = 0.5, y = -13}},
  atkrnd = { frate = 2, nframes = 5, anim = "play"},
  atksq1 = { frate = {2,2,2,2,2,2,2,6,4}, nframes = 9, anim = "play"},
  atksq2 = { frate = {2,2,2,2,6,4}, nframes = 6, anim = "play"},
  atksq3 = { frate = {2,2,2,2,2,2,2,6}, nframes = 8, anim = "play"},
  hitair = { frate =  0, nframes = 3, anim = Anim.Air3(60)},
  hitflr = { frate = 30, nframes = 1, anim = "play"},
  hitalt = { frate =  4, nframes = 2, anim = "play"},
  hithvy = { frate =  0, nframes = 1, anim = "idle"},
}

actor.list = {}
actor.list.auto = EnemyAuto(actor.extra):add{
  run = { move{x = 200} },
  runend = { isEnded / act("std") },
  atk =    { isFrame(5) / hitAll{dmg = 5}, isEnded / act("std") },
  atkup =  { isFrame(1) / hitAll{dmg = 15, hvy = {x = 0, y = 3}}, isEnded / act("jmp"), isFloor / act("std") },
  jmpatk = { isFrame(3) / hitAll{dmg =  5, hvy = {x = 1, y = 0}}, isEnded / act("jmp"), isFloor / act("std") },
  runatk = { isFrame(3) / hitAll{dmg = 10, hvy = {x = 2, y = 0}}, isEnded / act("std") },
  atkalt = { isFrame(5) / hitAll{dmg = 15, hvy = {x = 1, y = 0}}, isEnded / act("std") },
  atkrnd = { isFrame(2) / hitChk(isRng("x", 60), {dmg = 10, hvy = {x =  1.5}}),
             isEnded / act("std") },
  atksq1 = { isFrame(4) / hitAll{dmg =  5}, isEnded / act("std") },
  atksq2 = { isFrame(3) / hitAll{dmg =  5}, isEnded / act("std") },
  atksq3 = { isFrame(5) / hitAll{dmg = 10, hvy = {x = 1}}, isEnded / act("std") },
}

actor.list.keyb = ActorRules.new{
  std = { isKey{"ad>"}       / act("blk"),
          isKey{"b[rlud]*>"} / act("jmp")   / move{x =  100, y = -220, z = 0},
          isKey{"[rlud]+>"}  / act("wlk"),
          isKey{"a>"}        / act("atk"),
          isKey{"au>u>d>"}   / act("atkup") / move{y = -220, z = 0},
          isKey{"a[rl]>"}    / act("atkalt"),
          isKey{"ab>"}       / act("atkrnd") },
  wlk = { F{
            dir{x = 0, z = 0},
            isKeypress("r") / dir{x =  1},
            isKeypress("l") / dir{x = -1},
            isKeypress("u") / dir{z = -1},
            isKeypress("d") / dir{z =  1} },
          isKey{"r>r>", "l>l>"} / act("run"),
          isKey{"[rlud]+>"}     / act("wlk"),
          isKey{"[rlud]*b>"}    / act("jmp")   / move{x =  100, y = -200, z = 0},
          isKey{"au>u>d>"}      / act("atkup") / move{y = -200, z = 0},
          act("std")            / dir{x = 0, z = 0} },
  run = { isKey{"r>r>", "l>l>"}       / act("run"),
          isKey{"[rlud]*b>"}          / act("jmp")   / move{x =  200, y = -180, z = 0},
          isKey{"au>u>d>"}            / act("atkup") / move{y = -180, z = 0},
          isKey{"ar>r>r>", "al>l>l>"} / act("runatk"),
          act("runend") },
  blk = { isKey{"ad>"} / act("blk"),
          act("std") },
  jmp = { isKey{"a[rlud]*>"} / act("jmpatk") },  
  atk = { isKey{"a>a>"}        ^ isFrame(7) / act("atksq1") },
  atksq1 = { isKey{"a>a>a>"}   ^ isFrame(8) / act("atksq2") },
  atksq2 = { isKey{"a>a>a>a>"} ^ isFrame(5) / act("atksq3") },
}

actor.list.keyb:stop()
return actor