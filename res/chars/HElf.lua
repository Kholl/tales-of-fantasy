--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.box = {w = 24, h = 76}
actor.pmap = Game.assets["high elf pal"]

actor.info = {
  faction = "helf",
  hp = 100, hpmax = 100,
  mp =   0, mpmax =   0,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  
  state = {
    wlk = {
      spd = {x = 100, z = 100},
      rng = {min = 77},
      ep = 1,
    },

    atk = {
      hit = {[2] = {box = {x = 0, y = 0, w = 77, h = 89}}},
      rng = {min = 0, max = 77},
      ep = 160,
    },

    atksq1 = {
      hit = {[2] = {box = {x = 0, y = 34, w = 94, h = 47}, force = {x = 80}}},
      rng = {min = 0, max = 94},
      ep = 0,
    },

    atkalt = {
      hit = {[2] = {box = {x = 0, y = 11, w = 104, h = 55}}},
      rng = {min = 0, max = 104},
      ep = 160,
    },

    jmp = {
      rng = {min = 120, max = 140},
      spd = {x = 120, y = -240},
      ep = 120,
    },

    atkjmp = {
      hit = {[2] = {box = {x = 0, y = 0, w = 60, h = 41}}},
      rng = {min = 0, max = 110},
      ep = 0,
    },
    
    hitflr = {evade = true},
  },
}

actor.states = {
  std = {
    res = "res/chars/delf/std.png",
    dim = {w = 120, h = 72}, pad = {x = 0.5, y = 1},
    frate = 12, nframes = 2, anim = "loop"},
  wlk = {
    res = "res/chars/delf/wlk.png",
    dim = {w = 64, h = 62}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 8, anim = "loop"},
  jmp = {
    res = "res/chars/delf/jmp.png",
    dim = {w = 47, h = 74}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 1, anim = "idle"},
  hit = {
    res = "res/chars/delf/hit.png",
    dim = {w = 60, h = 68}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  hitair = {
    res = "res/chars/delf/hitair.png",
    dim = {w = 81, h = 42}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = Game.Anim.Air2(this)},
  hitflr = {
    res = "res/chars/delf/hitflr.png",
    dim = {w = 88, h = 22}, pad = {x = 0.5, y = 1},
    frate = 30, nframes = 1, anim = "play"},
  hitalt = {
    res = "res/chars/delf/hitalt.png",
    dim = {w = 100, h = 75}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  atk = {
    res = "res/chars/delf/atk1.png",
    dim = {w = 154, h = 89}, pad = {x = 0.5, y = -5},
    frate = 3, nframes = 7, anim = "play"},
  atksq1 = {
    res = "res/chars/delf/atk2.png",
    dim = {w = 188, h = 81}, pad = {x = 0.5, y = -1},
    frate = 3, nframes = 4, anim = "play"},
  atkalt = {
    res = "res/chars/delf/atk3.png",
    dim = {w = 211, h = 66}, pad = {x = 0.5, y = -1},
    frate = {3, [4] = 6}, nframes = 4, anim = "play"},
  atkjmp = {
    res = "res/chars/delf/atkair.png",
    dim = {w = 121, h = 79}, pad = {x = 0.5, y = -1},
    frate = 6, nframes = 3, anim = "play"},
}

return actor