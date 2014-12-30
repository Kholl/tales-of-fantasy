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
  hp = 125, hpmax = 125,
  mp =  75, mpmax =  75,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 110, z = 110},
      rng = {min = 45+31},
      ep = 1,
    },
    
    blk = {
      rng = {min = 20, max = 44},
      ep = 1,
    },

    atk = {
      hit = {[4] = {box = {x = 51, y = 36, w = 54, h = 3}, force = {x = 100}}},
      rng = {min = 51, max = 51+54},
      ep = 120,
    },
        
    atkalt = {
      hit = {[4] = {box = {x = 45, y = 18, w = 31, h = 44}, force = {x = 100}}},
      rng = {min = 45, max = 45+31},
      ep = 120,
    },
    
    jmp = {
      rng = {min = 160},
      spd = {x = 110, y = -220},
      ep = 160,
    },
  },
}

actor.states = {
  std = {
    res = "res/chars/delfboss/std.png",
    dim = {w = 80, h = 78}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 1, anim = "idle"},
  wlk = {
    res = "res/chars/delfboss/wlk.png",
    dim = {w = 83, h = 78}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 8, anim = "loop"},
  atk = {
    res = "res/chars/delfboss/atk1.png",
    dim = {w = 212, h = 80}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 4, anim = "play"},
  atkalt = {
    res = "res/chars/delfboss/atk2.png",
    dim = {w = 150, h = 81}, pad = {x = 0.5, y = -1},
    frate = {3, [6] = 9}, nframes = 6, anim = "play"},
  jmp = {
    res = "res/chars/delfboss/jmp.png",
    dim = {w = 60, h = 101}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = ANIM.Step2(function() return this:spd().y end)},
  hit = {
    res = "res/chars/delfboss/hit.png",
    dim = {w = 96, h = 77}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  hitair = {
    res = "res/chars/delfboss/hitair.png",
    dim = {w = 116, h = 46}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = ANIM.Step2(function() return this:spd().y end)},
  hitflr = {
    res = "res/chars/delfboss/hitflr.png",
    dim = {w = 123, h = 31}, pad = {x = 0.5, y = 1},
    frate = 30, nframes = 1, anim = "play"},
  hitalt = {
    res = "res/chars/delfboss/hitalt.png",
    dim = {w = 100, h = 75}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  blk = {
    res = "res/chars/delfboss/blk.png",
    dim = {w = 97, h = 80}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 1, anim = "idle"},
}

return actor