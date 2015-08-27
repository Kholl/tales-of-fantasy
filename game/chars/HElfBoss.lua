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

actor.info = {
  faction = "helf",
  hp = 125, hpmax = 125,
  mp =  75, mpmax =  75,
  dir = {x = 0, z = 0},
}

actor.states = {
  std = {
    res = "game/chars/delfboss/std.png",
    dim = {w = 80, h = 78},
    frate = 0,
    nframes = 1,
    anim = "idle"},
  wlk = {
    res = "game/chars/delfboss/wlk.png",
    dim = {w = 83, h = 78},
    frate = 3,
    nframes = 8,
    anim = "loop"},
  atk = {
    res = "game/chars/delfboss/atk1.png",
    dim = {w = 212, h = 80},
    frate = 3,
    nframes = 4,
    anim = "play"},
  atkalt = {
    res = "game/chars/delfboss/atk2.png",
    dim = {w = 150, h = 81},
    pad = {x = 0.5, y = -1},
    frate = 3,
    nframes = 5,
    anim = "play"},
  jmp = {
    res = "game/chars/delfboss/jmp.png",
    rad = 0,
    dim = {w = 60, h = 101},
    frate = 0,
    nframes = 2,
    anim = Anim.Air2()},
  hit = {
    res = "game/chars/delfboss/hit.png",
    dim = {w = 96, h = 77},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hitair = {
    res = "game/chars/delfboss/hitair.png",
    rad = 0,
    dim = {w = 116, h = 46},
    frate = 0,
    nframes = 2,
    anim = Anim.Air2()},
  hitflr = {
    res = "game/chars/delfboss/hitflr.png",
    dim = {w = 123, h = 31},
    frate = 30,
    nframes = 1,
    anim = "play"},
  die = {
    res = "game/chars/delfboss/hitflr.png",
    rad = 0,
    dim = {w = 123, h = 31}},
  hitalt = {
    res = "game/chars/delfboss/hitalt.png",
    dim = {w = 100, h = 75},
    frate = 4,
    nframes = 2,
    anim = "play"},
}

actor.rules = {
  wlk = {
    Script.move{x = 100, z = 100},
  },
  atk = {
    Script.isFrame(3) / Script.hitAll{dmg = 8},
    std = Script.isEnded,
  },
  hit = {
    hitair = -Script.isFloor,
    std = Script.isEnded,
  },
  hitair = {
    hitflr = Script.isFloor,
  },
  hitflr = {
    std = Script.isEnded,
    die = Script.isDied,
  },
  atkalt = {
    Script.isFrame(4) / Script.hitAll{dmg = 12},
    std = Script.isEnded,    
  },
  jmp = {
    std = Script.isFloor,
  },
}

actor.autorules = {
  std = {
    -Script.isTarget / Script.find,
    wlk = Script.isTarget,
    atk = Script.isTarget ^ Script.isHit("atk"),
    atkalt = Script.isTarget ^ Script.isHit("atkalt"),
    jmp = (Script.isTarget ^ Script.isRng("x", 140, 120)) / Script.move{x = 100, y = -240},
  },
  
  wlk = {
    Script.move{x = 100, z = 100},
    std = -Script.isTarget,
    wlk = Script.isTarget,
    atk = Script.isTarget ^ Script.isHit("atk"),
    atkalt = Script.isTarget ^ Script.isHit("atkalt") ^ Script.random(2),
    jmp = (Script.isTarget ^ Script.isRng("x", 140, 120)) / Script.move{x = 100, y = -240},
  },
}

actor.keybrules = {
  std = {
    atkalt = Script.isKey{"a[rl]>"},
    jmp = Script.isKey{"b[rlud]*>"} / Script.move{x = 100, y = -220},
    wlk = Script.isKey{"[rlud]+>"},
    atk = Script.isKey{"a>"},
  },
  wlk = {
    jmp = Script.isKey{"[rlud]*b>"} / Script.move{x = 100, y = -200},
    wlk = Script.isKey{"[rlud]+>"},
    std = -Script.isKey(),
  },
}

return actor