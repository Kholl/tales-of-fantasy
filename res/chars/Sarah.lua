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
  atkjmp = {
    res = "res/chars/lucia/atkjmp.png",
    rad = 0,
    dim = {w = 132, h = 96},
    frate = 2,
    nframes = 7,
    anim = "play"},
  jmp = {
    res = "res/chars/lucia/jmp.png",
    rad = 0,
    dim = {w = 62, h = 98},
    frate = 0,
    nframes = 8,
    anim = Game.Anim.Air(this)},
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
  die = {
    res = "res/chars/lucia/hitflr.png",
    rad = 0,
    dim = {w = 110, h = 49}},
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
  run = {
    res = "res/chars/lucia/run.png",
    dim = {w = 116, h = 64},
    frate = 2,
    nframes = 12,
    anim = "loop"},
  blk = {
    res = "res/chars/lucia/blk.png",
    dim = {w = 52, h = 67},
    frate = 2,
    nframes = 12,
    anim = "idle"},
  dodge = {
    res = "res/chars/lucia/atkflr.png",
    dim = {w = 106, h = 41},
    frate = {8, 16},
    nframes = 2,
    anim = "play"},
  runend = {
    res = "res/chars/lucia/runend.png",
    dim = {w = 100, h = 65},
    frate = {2, 2, 8},
    nframes = 3,
    anim = "play"},
  atkalt = {
    res = "res/chars/lucia/atk2h.png",
    dim = {w = 164, h = 96}, pad = {x = 0.5, y = -13},
    frate = {2.5, [9] = 7.5},
    nframes = 9,
    anim = "play"},
  atkrun = {
    res = "res/chars/lucia/atkrun.png",
    dim = {w = 160, h = 92},
    frate = {2, [5] = 10},
    nframes = 5,
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
}

actor.moves = {
  std = {
    ["[rl]a>"] = "atkalt",
    ["ua>u>d>"] = "atkup",
    ["r[dub]*>"] = "wlk",
    ["l[dub]*>"] = "wlk",
    ["[rl]*d[b]*>"] = "wlk",
    ["[rl]*u[b]*>"] = "wlk",
    ["a>"] = "atk",
    ["[rlud]*b>"] = "jmp",
    ["ab>"] = "atkrnd",
    ["da>"] = "blk",
  },
  wlk = {
    ["r[dub]*>"] = "wlk",
    ["l[dub]*>"] = "wlk",
    ["[rl]*d[b]*>"] = "wlk",
    ["[rl]*u[b]*>"] = "wlk",
    ["r>r>"] = "run",
    ["l>l>"] = "run",
    ["[rlud]*b>"] = "jmp",
  },
  run = {
    ["r>r>"] = "run",
    ["l>l>"] = "run",
    ["ra>r>r>"] = "runatk",
    ["la>l>l>"] = "runatk",
    ["[rlud]*b>"] = "jmp",
    ["rd>r>r>"] = "dodge",
    ["ld>l>l>"] = "dodge",
  },
  jmp = {["[rlud]*a>"] = "atkjmp"},
  atk = {["a>a>"] = "atksq1"},
  atksq1 = {["a>a>a>"] = "atksq2"},
  atksq2 = {["a>a>a>a>"] = "atksq3"},
  blk = {["da>"] = "blk"},
}

actor.rules = {
  std = {
    wlk = Game.Rule.action,
    jmp = Game.Rule.action,
    run = Game.Rule.action,
    blk = Game.Rule.action,
    atk = Game.Rule.action,
    atkalt = Game.Rule.action,
    atkup = Game.Rule.action,
    atkrnd = Game.Rule.action,
  },
  wlk = {
    run = Game.Rule.action,
    wlk = Game.Rule.action,
    jmp = Game.Rule.action,
    std = Game.Rule.idle,
  },
  run = {
    run = Game.Rule.action,
    jmp = Game.Rule.action,
    atkrun = Game.Rule.action,
    dodge = Game.Rule.action,
    runend = Game.Rule.idle,
  },
  runend = {
    std = Game.Rule.finish,
  },
  blk = {
    blk = Game.Rule.action,
    std = Game.Rule.idle,
  },
  dodge = {
    dodge = Game.Rule.finish,
  },
  atk = {
    atk = Game.Rule.attack,
    atksq1 = Game.Rule.chain,
    std = Game.Rule.finish,
  },
  atksq1 = {
    atksq1 = Game.Rule.attack,
    atksq2 = Game.Rule.chain,
    std = Game.Rule.finish,
  },
  atksq2 = {
    atksq2 = Game.Rule.attack,
    atksq3 = Game.Rule.chain,
    std = Game.Rule.finish,
  },
  atksq3 = {
    atksq3 = Game.Rule.attack,
    std = Game.Rule.finish,
  },
  jmp = {
    atkjmp = Game.Rule.action,
    std = Game.Rule.floor,
  },
  jmprun = {
    std = Game.Rule.floor,
  },
  hit = {
    hitair = Game.Rule.nofloor,
    std = Game.Rule.finish,
  },
  hitair = {
    hitflr = Game.Rule.floor,
  },
  hitflr = {
    std = Game.Rule.finish,
    die = Game.Rule.died,
  },
  hitalt = {
    hitair = Game.Rule.nofloor,
    std = Game.Rule.finish,
  },
  hithvy = {
    hitair = Game.Rule.fall,
  },
  atkjmp = {
    atkjmp = Game.Rule.attack,
    jmp = Game.Rule.finish,
    std = Game.Rule.floor,
  },
  atkalt = {
    atkalt = Game.Rule.attack,
    std = Game.Rule.finish,
  },
  atkrun = {
    atkrun = Game.Rule.attack,
    std = Game.Rule.finish,
  },
  atkup = {
    atkup = Game.Rule.attack,
    jmp = Game.Rule.finish,
  },
  atkrnd = {
    atkrnd = Game.Rule.attack,
    std = Game.Rule.finish,
  },
}

actor.info = {
  faction = "helf",
  hp =  75, hpmax =  75,
  mp = 125, mpmax = 125,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 100, z = 100},
      rng = {min = 60},
      ep = 1,
    },
    
    run = {
      spd = {x = 200},
      rng = {min = 160},
      ep = 1,
    },
    
    blk = {
      rng = {min = 0, max = 40},
      ep = 1,
    },
    
    dodge = {
      evade = true,
      spd = {x = 300},
      rng = {min = 40, max = 120},
      ep = 120,
    },

    atk = {
      dmg = 6,
      hit = {[5] = {box = {x = 0, y = 0, w = 82, h = 82}}},
      rng = {min = 0, max = 82},
      ep = 120,
    },
    
    jmp = {
      rng = {min = 120, max = 140},
      spd = {x = 100, y = -220},
      ep = 120,
    },
    
    atkjmp = {
      dmg = 8,
      hit = {[3] = {box = {x = 0, y = 0, w = 80, h = 96}, force = {x = 120}}},
      rng = {min = 0, max = 80},
      ep = 0,
    },
    
    atkalt = {
      dmg = 10,
      hit = {[5] = {box = {x = 0, y = 0, w = 82, h = 96}, force = {x = 100, y = -200}}},
      rng = {min = 0, max = 82},
      ep = 120,
    },

    atkrun = {
      dmg = 6,
      hit = {[3] = {box = {x = 0, y = 0, w = 80, h = 92}, force = {x = 180, y = -220}}},
      rng = {min = 0, max = 80},
      ep = 120,
    },
    
    atkup = {
      evade = true,
      dmg = 8,
      spd = {y = -220},
      hit = {[1] = {box = {x = 0, y = 0, w = 60, h = 95}, force = {x = 0, y = -220}}},
      rng = {min = 0, max = 60},
      ep = 120,
    },
    
    atkrnd = {
      evade = true,
      dmg = 8,
      hit = {
        [1] = {box = {x = -81, y = 13, w = 81, h = 69}, force = {x = 100, y = -200}},
        [3] = {box = {x =   0, y = 13, w = 81, h = 69}, force = {x = 100, y = -200}},
      },
      rng = {min = 0, max = 81},
      ep = 120,
    },
    
    atksq1 = {
      dmg = 8,
      hit = {[4] = {box = {x = 0, y = 0, w = 100, h = 73}}},
      rng = {min = 0, max = 100},
      ep = 0,
    },
    
    atksq2 = {
      dmg = 10,
      hit = {[3] = {box = {x = 0, y = 14, w = 105, h = 51}}},
      rng = {min = 0, max = 105},
      ep = 0,
    },
  
    atksq3 = {
      dmg = 12,
      hit = {[5] = {box = {x = 0, y = 0, w = 111, h = 85}, force = {x = 180, y = -220}}},
      rng = {min = 0, max = 111},
      ep = 0,
    },
    
    hitflr = {evade = true},
    die = {evade = true},
  },
}

return actor