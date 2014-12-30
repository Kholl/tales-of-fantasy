--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

ANIM = {
  Step2 = function(func)
    return function(sprite)
      if func() < 0 then return 0 else return 1 end
    end
  end,
}

actor = {}
actor.action = false
actor.state = "std"
actor.box = {w = 24, h = 76}

actor.info = {
  faction = "elven",
  hp = 100, hpmax = 100,
  mp =   0, mpmax =   0,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 110, z = 110},
      rng = {min = 45+31},
      ep = 1,
    },

    atk = {
      hit = {[2] = {box = {x = 41, y = 34, w = 38, h = 20}, force = {x = 80}}},
      rng = {min = 41, max = 41+38},
      ep = 160,
    },

    atksq1 = {
      hit = {[1] = {box = {x = 37, y = 31, w = 45, h = 10}, force = {x = 80}}},
      rng = {min = 37, max = 37+45},
      ep = 0,
    },

    atkalt = {
      hit = {[2] = {box = {x = 76, y = 8, w = 40, h = 16}, force = {x = 100}}},
      rng = {min = 76, max = 76+40},
      ep = 160,
    },

    atkjmp = {
      hit = {[2] = {box = {x = 24, y = 23, w = 37, h = 19}, force = {x = 120, y = 10}}},
      rng = {min = 24, max = 24+37+25},
      ep = 120,
    },
    
    jmp = {
      rng = {min = 80, max = 110},
      spd = {x = 110, y = -220},
      ep = 1,
    },
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
  hitalt = {
    res = "res/chars/delf/hitalt.png",
    dim = {w = 104, h = 61}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 3, anim = "play"},
  hitair = {
    res = "res/chars/delf/hitair.png",
    dim = {w = 81, h = 42}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = ANIM.Step2(function() return this:spd().y end)},
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