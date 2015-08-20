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
}

actor.states = {
  std = { frate = 8, nframes =  3, anim = "loop"},
  wlk = { frate = 2, nframes = 12, anim = "loop"},
  atk = { frate = {2,2,2,2,2,2,6,4}, nframes = 8, anim = "play"},
  jmp = { frate = 0, nframes =  8, anim = Anim.Air(-220)},
  run = { frate = 2, nframes = 12, anim = "loop"},
  hit = { frate = {3,5}, nframes =  2, anim = "play"},
  blk = { frate = 2, nframes = 1, anim = "idle"},
  atkup = { frate = 4, nframes = 4, anim = "play"},
  jmpatk = { frate = {2,2,2,2,2,6,4}, nframes = 7, anim = "play"},
  runend = { frate = {2,2,8}, nframes = 3, anim = "play"},
  runatk = { frate = {2,2,2,4,8}, nframes = 5, anim = "play"},
  atkalt = { frate = {2,2,2,2,2,2,2,4,8}, nframes = 9, anim = "play", pad = {x = 0.5, y = -13}},
  atkrnd = { frate = 3, nframes = 5, anim = "play"},
  atksq1 = { frate = {2,2,2,2,2,2,2,6,4}, nframes = 9, anim = "play"},
  atksq2 = { frate = {2,2,2,2,6,4}, nframes = 6, anim = "play"},
  atksq3 = { frate = {2,2,2,2,2,2,6,4}, nframes = 8, anim = "play"},
  hitair = { frate =  0, nframes = 3, anim = Anim.Air3(60)},
  hitflr = { frate = 30, nframes = 1, anim = "play"},
  hitalt = { frate =  4, nframes = 2, anim = "play"},
  hithvy = { frate =  0, nframes = 1, anim = "idle"},
}

actor.list = {}
actor.list.auto = ActorDlg.new{
  wlk = {  ActorScript.move{x = 100, z = 100} },
  atk = {  ActorScript.isFrame(5) / ActorScript.hitAll(Game.dmg(6)),
           ActorScript.isEnded / ActorScript.act("std") },
  jmp = {  ActorScript.isFloor / ActorScript.act("std") },
  run = {  ActorScript.move{x = 200} },
  hit = { -ActorScript.isFloor / ActorScript.act("hitair"),
           ActorScript.isEnded / ActorScript.act("std") },
  atkup = { ActorScript.isFrame(1) / ActorScript.hitAll(Game.dmg(6, {y = -220})),
            ActorScript.isEnded / ActorScript.act("jmp"),
            ActorScript.isFloor / ActorScript.act("std") },
  jmpatk = {  ActorScript.isFrame(3) / ActorScript.hitAll(Game.dmg(6, {x = 120})),
              ActorScript.isEnded / ActorScript.act("jmp"),
              ActorScript.isFloor / ActorScript.act("std") },
  runend = {  ActorScript.isEnded / ActorScript.act("std") },
  runatk = {  ActorScript.isFrame(3) / ActorScript.hitAll(Game.dmg(6, {x = 180, y = -220})),
              ActorScript.isEnded / ActorScript.act("std") },
  atkalt = {  ActorScript.isFrame(5) / ActorScript.hitAll(Game.dmg(6, {x = 100, y = -200})),
              ActorScript.isEnded / ActorScript.act("std") },
  atkrnd = {  ActorScript.isFrame(1) / ActorScript.hitAll(Game.dmg(6, {x = 100, y = -200})),
              ActorScript.isEnded / ActorScript.act("std") },
  atksq1 = {  ActorScript.isFrame(4) / ActorScript.hitAll(Game.dmg(8)),
              ActorScript.isEnded / ActorScript.act("std") },
  atksq2 = {  ActorScript.isFrame(3) / ActorScript.hitAll(Game.dmg(10)),
              ActorScript.isEnded / ActorScript.act("std") },
  atksq3 = {  ActorScript.isFrame(5) / ActorScript.hitAll(Game.dmg(12, {x = 140, y = -200})),
              ActorScript.isEnded / ActorScript.act("std") },
  hitair = {  ActorScript.isFloor / ActorScript.act("hitflr") },
  hitflr = {  ActorScript.isEnded / ActorScript.act("std") },
  hitalt = { -ActorScript.isFloor / ActorScript.act("hitair"),
              ActorScript.isEnded / ActorScript.act("std") },
  hithvy = {  ActorScript.isFall / ActorScript.act("hitair") },
}

actor.list.keyb = ActorDlg.new{
  std = { ActorScript.isKey{"ad>"} / ActorScript.act("blk"),
          ActorScript.isKey{"b[rlud]*>"} / ActorScript.act("jmp") / ActorScript.move{x =  100, y = -220, z = 0},
          ActorScript.isKey{"[rlud]+>"} / ActorScript.act("wlk"),
          ActorScript.isKey{"a>"} / ActorScript.act("atk"),
          ActorScript.isKey{"au>u>d>"} / ActorScript.act("atkup") / ActorScript.move{y = -220, z = 0},
          ActorScript.isKey{"a[rl]>"} / ActorScript.act("atkalt"),
          ActorScript.isKey{"ab>"} / ActorScript.act("atkrnd") },
  wlk = { ActorScript.all{
            ActorScript.dir{x = 0, z = 0},
            ActorScript.isKeypress("r") / ActorScript.dir{x =  1},
            ActorScript.isKeypress("l") / ActorScript.dir{x = -1},
            ActorScript.isKeypress("u") / ActorScript.dir{z = -1},
            ActorScript.isKeypress("d") / ActorScript.dir{z =  1},
          },
          ActorScript.isKey{"r>r>", "l>l>"} / ActorScript.act("run"),
          ActorScript.isKey{"[rlud]+>"} / ActorScript.act("wlk"),
          ActorScript.isKey{"[rlud]*b>"} / ActorScript.act("jmp") / ActorScript.move{x =  100, y = -200, z = 0},
          ActorScript.isKey{"au>u>d>"} / ActorScript.act("atkup") / ActorScript.move{y = -200, z = 0},
          ActorScript.act("std") / ActorScript.dir{x = 0, z = 0} },
  run = { ActorScript.isKey{"r>r>", "l>l>"} / ActorScript.act("run"),
          ActorScript.isKey{"[rlud]*b>"} / ActorScript.act("jmp") / ActorScript.move{x =  200, y = -180, z = 0},
          ActorScript.isKey{"au>u>d>"} / ActorScript.act("atkup") / ActorScript.move{y = -180, z = 0},
          ActorScript.isKey{"ar>r>r>", "al>l>l>"} / ActorScript.act("runatk"),
          ActorScript.act("runend") },
  blk = { ActorScript.isKey{"ad>"} / ActorScript.act("blk"),
          ActorScript.act("std") },
  jmp = { ActorScript.isKey{"a[rlud]*>"} / ActorScript.act("jmpatk") },  
  atk = { ActorScript.isKey{"a>a>"} ^ ActorScript.isFrame(7) / ActorScript.act("atksq1") },
  atksq1 = { ActorScript.isKey{"a>a>a>"} ^ ActorScript.isFrame(8) / ActorScript.act("atksq2") },
  atksq2 = { ActorScript.isKey{"a>a>a>a>"} ^ ActorScript.isFrame(5) / ActorScript.act("atksq3") },
}

actor.list.keyb:stop()
return actor