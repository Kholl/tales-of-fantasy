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
actor.pmap = Game.Assets["high elf pal"]

actor.states = {
  std = {
    res = "game/chars/delf/std.png",
    dim = {w = 120, h = 72},
    frate = 12,
    nframes = 2,
    anim = "loop"},
  wlk = {
    res = "game/chars/delf/wlk.png",
    dim = {w = 64, h = 62},
    frate = 3,
    nframes = 8,
    anim = "loop"},
  jmp = {
    res = "game/chars/delf/jmp.png",
    rad = 0,
    dim = {w = 47, h = 74},
    frate = 0,
    nframes = 1,
    anim = "idle"},
  hit = {
    res = "game/chars/delf/hit.png",
    dim = {w = 60, h = 68},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hitair = {
    res = "game/chars/delf/hitair.png",
    rad = 0,
    dim = {w = 81, h = 42},
    frate = 0,
    nframes = 2,
    anim = Game.Anim.Air2(this)},
  hitflr = {
    res = "game/chars/delf/hitflr.png",
    dim = {w = 88, h = 22},
    frate = 30,
    nframes = 1,
    anim = "play"},
  die = {
    res = "game/chars/delf/hitflr.png",
    rad = 0,
    dim = {w = 88, h = 22}},
  hitalt = {
    res = "game/chars/delf/hitalt.png",
    dim = {w = 100, h = 75},
    frate = 4,
    nframes = 2,
    anim = "play"},
  atk = {
    res = "game/chars/delf/atk1.png",
    dim = {w = 154, h = 89},
    pad = {x = 0.5, y = -5},
    frate = 3,
    nframes = 7,
    anim = "play"},
  atksq1 = {
    res = "game/chars/delf/atk2.png",
    dim = {w = 188, h = 81},
    pad = {x = 0.5, y = -1},
    frate = 3,
    nframes = 4,
    anim = "play"},
  atkalt = {
    res = "game/chars/delf/atk3.png",
    dim = {w = 211, h = 66},
    pad = {x = 0.5, y = -1},
    frate = {3, [4] = 6},
    nframes = 4,
    anim = "play"},
  atkjmp = {
    res = "game/chars/delf/atkair.png",
    rad = 0,
    dim = {w = 121, h = 79},
    pad = {x = 0.5, y = -1},
    frate = 6,
    nframes = 3,
    anim = "play"},
}

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
      dmg = 5,
      hit = {[2] = {box = {x = 0, y = 0, w = 77, h = 89}}},
      rng = {min = 0, max = 77},
      ep = 160,
    },

    atksq1 = {
      dmg = 8,
      hit = {[2] = {box = {x = 0, y = 34, w = 94, h = 47}, force = {x = 80}}},
      rng = {min = 0, max = 94},
      ep = 0,
    },

    atkalt = {
      dmg = 10,
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
      dmg = 10,
      hit = {[2] = {box = {x = 0, y = 0, w = 60, h = 41}}},
      rng = {min = 0, max = 110},
      ep = 0,
    },
    
    hitflr = {evade = true},
    die = {evade = true},
  },
}

return actor