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

actor.info = {
  faction = "helf",
  hp =  75, hpmax =  75,
  mp = 125, mpmax = 125,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
}

actor.states = {
  std = {
    res = "res/chars/lucia/std.png",
    dim = {w = 59, h = 69},
    frate = 8,
    nframes = 3,
    anim = "loop"},
  wlk = {
    res = "res/chars/lucia/wlk.png",
    dim = {w = 50, h = 68},
    frate = 2,
    nframes = 12, anim = "loop"},
  atk = {
    res = "res/chars/lucia/atk.png",
    dim = {w = 164, h = 82},
    frate = {2, [8] = 6},
    nframes = 8, anim = "play"},
  jmp = {
    res = "res/chars/lucia/jmp.png",
    rad = 0,
    dim = {w = 62, h = 98},
    frate = 0,
    nframes = 8,
    anim = Game.Anim.Air(this, -220)},
  jmpatk = {
    res = "res/chars/lucia/jmpatk.png",
    rad = 0,
    dim = {w = 132, h = 96},
    frate = 2,
    nframes = 7,
    anim = "play"},
  run = {
    res = "res/chars/lucia/run.png",
    dim = {w = 116, h = 64},
    frate = 2,
    nframes = 12,
    anim = "loop"},
  runend = {
    res = "res/chars/lucia/runend.png",
    dim = {w = 100, h = 65},
    frate = {2, 2, 8},
    nframes = 3,
    anim = "play"},
  runatk = {
    res = "res/chars/lucia/runatk.png",
    dim = {w = 160, h = 92},
    frate = {2, [5] = 10},
    nframes = 5,
    anim = "play"},
  atkalt = {
    res = "res/chars/lucia/atk2h.png",
    dim = {w = 164, h = 96}, pad = {x = 0.5, y = -13},
    frate = {2.5, [9] = 7.5},
    nframes = 9,
    anim = "play"},
  atkup = {
    res = "res/chars/lucia/atkup.png",
    dim = {w = 120, h = 95},
    frate = 4,
    nframes = 4,
    anim = "play"},
  atkrnd = {
    res = "res/chars/lucia/atkrnd.png",
    dim = {w = 162, h = 82},
    frate = 2,
    nframes = 5,
    anim = "play"},
  atksq1 = {
    res = "res/chars/lucia/atksq1.png",
    dim = {w = 200, h = 73},
    frate = {2, [9] = 6},
    nframes = 9,
    anim = "play"},
  atksq2 = {
    res = "res/chars/lucia/atksq2.png",
    dim = {w = 210, h = 65},
    frate = {2, [6] = 6},
    nframes = 6,
    anim = "play"},
  atksq3 = {
    res = "res/chars/lucia/atksq3.png",
    dim = {w = 222, h = 85},
    frate = {2, [8] = 6},
    nframes = 8,
    anim = "play"},
  hit = {
    res = "res/chars/lucia/hit.png",
    dim = {w = 48, h = 68},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hitair = {
    res = "res/chars/lucia/hitair.png",
    rad = 0,
    dim = {w = 110, h = 49},
    frate = 0,
    nframes = 4,
    anim = Game.Anim.Air3(this, 60)},
  hitflr = {
    res = "res/chars/lucia/hitflr.png",
    dim = {w = 110, h = 49},
    frate = 30,
    nframes = 1,
    anim = "play"},
  hitalt = {
    res = "res/chars/lucia/hitalt.png",
    dim = {w = 57, h = 62},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hithvy = {
    res = "res/chars/lucia/hithvy.png",
    dim = {w = 130, h = 51},
    frate = 0,
    nframes = 1,
    anim = "idle"},
  die = {
    res = "res/chars/lucia/hitflr.png",
    rad = 0,
    dim = {w = 110, h = 49}},
  blk = {
    res = "res/chars/lucia/blk.png",
    dim = {w = 52, h = 67},
    frate = 2,
    nframes = 12,
    anim = "idle"},
}

actor.rules = {
  atk = {
    Actor.isFrame(5) / Actor.hitAll{dmg = 6},
    std = Actor.isEnded,
  },
  jmp = {
    std = Scene.isFloor,
  },
  jmpatk = {
    Actor.isFrame(3) / Actor.hitAll{dmg = 8, force = {x = 120}},
    jmp = Actor.isEnded,
    std = Scene.isFloor,
  },
  runend = {
    std = Actor.isEnded,
  },
  runatk = {
    Actor.isFrame(3) / Actor.hitAll{dmg = 6, force = {x = 180, y = -220}},
    std = Actor.isEnded,
  },
  atkalt = {
    Actor.isFrame(5) / Actor.hitAll{dmg = 10, force = {x = 100, y = -200}},
    std = Actor.isEnded,
  },
  atkup = {
    Actor.isFrame(1) / Actor.hitAll{dmg = 8, force = {y = -220}},
    jmp = Actor.isEnded,
    std = Scene.isFloor,
  },
  atkrnd = {
    Actor.isFrame(1) / Actor.hitAll{dmg = 8, force = {x = 100, y = -200}},
    std = Actor.isEnded,
  },
  atksq1 = {
    Actor.isFrame(4) / Actor.hitAll{dmg = 8},
    std = Actor.isEnded,
  },
  atksq2 = {
    Actor.isFrame(3) / Actor.hitAll{dmg = 10},
    std = Actor.isEnded,
  },
  atksq3 = {
    Actor.isFrame(5) / Actor.hitAll{dmg = 12},
    std = Actor.isEnded,
  },
  hit = {
    hitair = -Scene.isFloor,
    std = Actor.isEnded,
  },
  hitair = {
    hitflr = Scene.isFloor,
  },
  hitflr = {
    std = Actor.isEnded,
    die = Actor.isDied,
  },
  hitalt = {
    hitair = -Scene.isFloor,
    std = Actor.isEnded,
  },
  hithvy = {
    hitair = Actor.isFall,
  },
}

actor.keybrules = {
  std = {
    atkup = Actor.isKey{"au>u>d>"} / Actor.move{spd = {y = -220}},
    atkalt = Actor.isKey{"a[rl]>"},
    atkrnd = Actor.isKey{"ab>"},
    blk = Actor.isKey{"ad>"},
    jmp = Actor.isKey{"b[rlud]*>"} / Actor.move{spd = {x = 100, y = -220}},
    wlk = Actor.isKey{"[rlud]+>"},
    atk = Actor.isKey{"a>"},
  },
  wlk = {
    atkup = Actor.isKey{"au>u>d>"} / Actor.move{spd = {y = -200}},
    jmp = Actor.isKey{"[rlud]*b>"} / Actor.move{spd = {x = 100, y = -200}},
    run = Actor.isKey{"r>r>", "l>l>"},
    wlk = Actor.isKey{"[rlud]+>"} / Actor.move{spd = {x = 100, z = 100}},
    std = -Actor.isKey(),
  },
  atk = {
    atksq1 = Actor.isKey{"a>a>"} ^ Actor.isEnded,
  },
  jmp = {
    jmpatk = Actor.isKey{"a[rlud]*>"},
  },
  run = {
    atkup = Actor.isKey{"au>u>d>"} / Actor.move{spd = {y = -180}},
    runatk = Actor.isKey{"ar>r>r>", "al>l>l>"},
    run = Actor.isKey{"r>r>", "l>l>"} / Actor.move{spd = {x = 200}},
    jmp = Actor.isKey{"[rlud]*b>"} / Actor.move{spd = {x = 200, y = -180}},
    runend = -Actor.isKey(),
  },
  atksq1 = {
    atksq2 = Actor.isKey{"a>a>a>"} ^ Actor.isEnded,
  },
  atksq2 = {
    atksq3 = Actor.isKey{"a>a>a>a>"} ^ Actor.isEnded,
  },
  blk = {
    blk = Actor.isKey{"ad>"},
    std = -Actor.isKey(),
  },
}

return actor