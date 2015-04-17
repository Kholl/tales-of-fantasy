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
  dir = {x = 0, z = 0},
}

actor.states = {
  std = {
    res = "game/chars/lucia/std.png",
    dim = {w = 59, h = 69},
    frate = 8,
    nframes = 3,
    anim = "loop"},
  wlk = {
    res = "game/chars/lucia/wlk.png",
    dim = {w = 50, h = 68},
    frate = 2,
    nframes = 12, anim = "loop"},
  atk = {
    res = "game/chars/lucia/atk.png",
    dim = {w = 164, h = 82},
    frate = {2, [8] = 6},
    nframes = 8, anim = "play"},
  jmp = {
    res = "game/chars/lucia/jmp.png",
    rad = 0,
    dim = {w = 62, h = 98},
    frate = 0,
    nframes = 8,
    anim = Anim.Air(-220)},
  jmpatk = {
    res = "game/chars/lucia/jmpatk.png",
    rad = 0,
    dim = {w = 132, h = 96},
    frate = 2,
    nframes = 7,
    anim = "play"},
  run = {
    res = "game/chars/lucia/run.png",
    dim = {w = 116, h = 64},
    frate = 2,
    nframes = 12,
    anim = "loop"},
  runend = {
    res = "game/chars/lucia/runend.png",
    dim = {w = 100, h = 65},
    frate = {2, 2, 8},
    nframes = 3,
    anim = "play"},
  runatk = {
    res = "game/chars/lucia/runatk.png",
    dim = {w = 160, h = 92},
    frate = {2, [5] = 10},
    nframes = 5,
    anim = "play"},
  atkalt = {
    res = "game/chars/lucia/atk2h.png",
    dim = {w = 164, h = 96}, pad = {x = 0.5, y = -13},
    frate = {2.5, [9] = 7.5},
    nframes = 9,
    anim = "play"},
  atkup = {
    res = "game/chars/lucia/atkup.png",
    dim = {w = 120, h = 95},
    frate = 4,
    nframes = 4,
    anim = "play"},
  atkrnd = {
    res = "game/chars/lucia/atkrnd.png",
    dim = {w = 162, h = 82},
    frate = 2,
    nframes = 5,
    anim = "play"},
  atksq1 = {
    res = "game/chars/lucia/atksq1.png",
    dim = {w = 200, h = 73},
    frate = {2, [9] = 6},
    nframes = 9,
    anim = "play"},
  atksq2 = {
    res = "game/chars/lucia/atksq2.png",
    dim = {w = 210, h = 65},
    frate = {2, [6] = 6},
    nframes = 6,
    anim = "play"},
  atksq3 = {
    res = "game/chars/lucia/atksq3.png",
    dim = {w = 222, h = 85},
    frate = {2, [8] = 6},
    nframes = 8,
    anim = "play"},
  hit = {
    res = "game/chars/lucia/hit.png",
    dim = {w = 48, h = 68},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hitair = {
    res = "game/chars/lucia/hitair.png",
    rad = 0,
    dim = {w = 110, h = 49},
    frate = 0,
    nframes = 4,
    anim = Anim.Air3(60)},
  hitflr = {
    res = "game/chars/lucia/hitflr.png",
    dim = {w = 110, h = 49},
    frate = 30,
    nframes = 1,
    anim = "play"},
  hitalt = {
    res = "game/chars/lucia/hitalt.png",
    dim = {w = 57, h = 62},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hithvy = {
    res = "game/chars/lucia/hithvy.png",
    dim = {w = 130, h = 51},
    frate = 0,
    nframes = 1,
    anim = "idle"},
  die = {
    res = "game/chars/lucia/hitflr.png",
    rad = 0,
    dim = {w = 110, h = 49}},
  blk = {
    res = "game/chars/lucia/blk.png",
    dim = {w = 52, h = 67},
    frate = 2,
    nframes = 12,
    anim = "idle"},
}

actor.rules = {
  wlk = {
    ActorScript.move{x = 100, z = 100},
  },
  atk = {
    ActorScript.isFrame(5) / ActorScript.hitAll{dmg = 6},
    std = ActorScript.isEnded,
  },
  jmp = {
    std = SceneScript.isFloor,
  },
  jmpatk = {
    ActorScript.isFrame(3) / ActorScript.hitAll{dmg = 8, force = {x = 120}},
    jmp = ActorScript.isEnded,
    std = SceneScript.isFloor,
  },
  run = {
    ActorScript.move{x = 200},
  },
  runend = {
    std = ActorScript.isEnded,
  },
  runatk = {
    ActorScript.isFrame(3) / ActorScript.hitAll{dmg = 6, force = {x = 180, y = -220}},
    std = ActorScript.isEnded,
  },
  atkalt = {
    ActorScript.isFrame(5) / ActorScript.hitAll{dmg = 10, force = {x = 100, y = -200}},
    std = ActorScript.isEnded,
  },
  atkup = {
    ActorScript.isFrame(1) / ActorScript.hitAll{dmg = 8, force = {y = -220}},
    jmp = ActorScript.isEnded,
    std = SceneScript.isFloor,
  },
  atkrnd = {
    ActorScript.isFrame(1) / ActorScript.hitAll{dmg = 8, force = {x = 100, y = -200}},
    std = ActorScript.isEnded,
  },
  atksq1 = {
    ActorScript.isFrame(4) / ActorScript.hitAll{dmg = 8},
    std = ActorScript.isEnded,
  },
  atksq2 = {
    ActorScript.isFrame(3) / ActorScript.hitAll{dmg = 10},
    std = ActorScript.isEnded,
  },
  atksq3 = {
    ActorScript.isFrame(5) / ActorScript.hitAll{dmg = 12},
    std = ActorScript.isEnded,
  },
  hit = {
    hitair = -SceneScript.isFloor,
    std = ActorScript.isEnded,
  },
  hitair = {
    hitflr = SceneScript.isFloor,
  },
  hitflr = {
    std = ActorScript.isEnded,
    die = ActorScript.isDied,
  },
  hitalt = {
    hitair = -SceneScript.isFloor,
    std = ActorScript.isEnded,
  },
  hithvy = {
    hitair = ActorScript.isFall,
  },
}

actor.keybrules = {
  std = {
    atkup = ActorScript.isKey{"au>u>d>"} / ActorScript.move{y = -220},
    atkalt = ActorScript.isKey{"a[rl]>"},
    atkrnd = ActorScript.isKey{"ab>"},
    blk = ActorScript.isKey{"ad>"},
    jmp = ActorScript.isKey{"b[rlud]*>"} / ActorScript.move{x = 100, y = -220},
    wlk = ActorScript.isKey{"[rlud]+>"},
    atk = ActorScript.isKey{"a>"},
  },
  wlk = {
    atkup = ActorScript.isKey{"au>u>d>"} / ActorScript.move{y = -200},
    jmp = ActorScript.isKey{"[rlud]*b>"} / ActorScript.move{x = 100, y = -200},
    run = ActorScript.isKey{"r>r>", "l>l>"},
    wlk = ActorScript.isKey{"[rlud]+>"},
    std = -ActorScript.isKey(),
  },
  atk = {
    atksq1 = ActorScript.isKey{"a>a>"} ^ ActorScript.isEnded,
  },
  jmp = {
    jmpatk = ActorScript.isKey{"a[rlud]*>"},
  },
  run = {
    atkup = ActorScript.isKey{"au>u>d>"} / ActorScript.move{y = -180},
    runatk = ActorScript.isKey{"ar>r>r>", "al>l>l>"},
    run = ActorScript.isKey{"r>r>", "l>l>"},
    jmp = ActorScript.isKey{"[rlud]*b>"} / ActorScript.move{x = 200, y = -180},
    runend = -ActorScript.isKey(),
  },
  atksq1 = {
    atksq2 = ActorScript.isKey{"a>a>a>"} ^ ActorScript.isEnded,
  },
  atksq2 = {
    atksq3 = ActorScript.isKey{"a>a>a>a>"} ^ ActorScript.isEnded,
  },
  blk = {
    blk = ActorScript.isKey{"ad>"},
    std = -ActorScript.isKey(),
  },
}

return actor