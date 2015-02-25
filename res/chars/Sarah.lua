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
  std = {
    atkup = this.isKey({"au>u>d>"}, this.move{spd = {y = -220}}),
    atkalt = this.isKey{"a[rl]>"},
    atkrnd = this.isKey{"ab>"},
    blk = this.isKey{"ad>"},
    jmp = this.isKey({"b[rlud]*>"}, this.move{spd = {x = 100, y = -220}}),
    wlk = this.isKey{"[rlud]+>"},
    atk = this.isKey{"a>"},
  },
  wlk = {
    atkup = this.isKey({"au>u>d>"}, this.move{spd = {y = -200}}),
    jmp = this.isKey({"[rlud]*b>"}, this.move{spd = {x = 100, y = -200}}),
    run = this.isKey{"r>r>", "l>l>"},
    wlk = this.isKey({"[rlud]+>"}, this.move{spd = {x = 100, z = 100}}),
    std = this.isNoKey,
  },
  atk = {
    this.isFrame(5, this.attack{dmg = 6}),
    std = this.isEnded,
    atksq1 = this.isChain{"a>a>"},
  },
  jmp = {
    jmpatk = this.isKey{"a[rlud]*>"},
    std = this.isFloor,
  },
  jmpatk = {
    this.isFrame(3, this.attack{dmg = 8, force = {x = 120}}),
    jmp = this.isEnded,
    std = this.isFloor,
  },
  run = {
    atkup = this.isKey({"au>u>d>"}, this.move{spd = {y = -180}}),
    runatk = this.isKey{"ar>r>r>", "al>l>l>"},
    run = this.isKey({"r>r>", "l>l>"}, this.move{spd = {x = 200}}),
    jmp = this.isKey({"[rlud]*b>"}, this.move{spd = {x = 200, y = -180}}),
    runend = this.isNoKey,
  },
  runend = {
    std = this.isEnded,
  },
  runatk = {
    this.isFrame(3, this.attack{dmg = 6, force = {x = 180, y = -220}}),
    std = this.isEnded,
  },
  atkalt = {
    this.isFrame(5, this.attack{dmg = 10, force = {x = 100, y = -200}}),
    std = this.isEnded,
  },
  atkup = {
    this.isFrame(1, this.attack{dmg = 8, force = {y = -220}}),
    jmp = this.isEnded,
    std = this.isFloor,
  },
  atkrnd = {
    this.isFrame(1, this.attack{dmg = 8, force = {x = 100, y = -200}}),
    std = this.isEnded,
  },
  atksq1 = {
    this.isFrame(4, this.attack{dmg = 8}),
    std = this.isEnded,
    atksq2 = this.isChain{"a>a>a>"},
  },
  atksq2 = {
    this.isFrame(3, this.attack{dmg = 10}),
    std = this.isEnded,
    atksq3 = this.isChain{"a>a>a>a>"},
  },
  atksq3 = {
    this.isFrame(5, this.attack{dmg = 12}),
    std = this.isEnded,
  },
  hit = {
    hitair = this.noFloor,
    std = this.isEnded,
  },
  hitair = {
    hitflr = this.isFloor,
  },
  hitflr = {
    std = this.isEnded,
    die = this.isDied,
  },
  hitalt = {
    hitair = this.noFloor,
    std = this.isEnded,
  },
  hithvy = {
    hitair = this.isFall,
  },
  blk = {
    blk = this.isKey{"ad>"},
    std = this.isNoKey,
  },
}

return actor