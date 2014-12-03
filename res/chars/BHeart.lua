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
actor.box = {w = 82, h = 144}

actor.info = {
  faction = "demon",
  hp = 500, hpmax = 500,
  mp = 500, mpmax = 500,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 90, z = 45},
      rng = {min = 136+36},
      ep = 1,
    },
        
    atk = {
      hit = {[2] = {box = {x = 44, y = 53, w = 101, h = 55}, force = {x = 160}}},
      rng = {min = 44, max = 101+44},
      ep = 165,
    },
        
    atkalt = {
      hit = {[3] = {box = {x = 36, y = 75, w = 136, h = 40}, force = {x = 160}}},
      rng = {min = 36, max = 136+36},
      ep = 165,
    },
--[[        
    atkflr = {
      hit = {[3] = {box = {x = 60, y = 101, w = 55, h = 63}, force = {x = 60, y = -10}}},
      rng = {min = 60, max = 101+60},
    },
]]--
  },
}

actor.states = {
  std = {
    res = "res/chars/BHeart/std.png",
    dim = {w = 127, h = 177}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 8, anim = "loop"},
  wlk = {
    res = "res/chars/BHeart/wlk.png",
    dim = {w = 150, h = 168}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 12, anim = "loop"},
  hit = {
    res = "res/chars/BHeart/hit.png",
    dim = {w = 200, h = 167}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 3, anim = "play"},
  hitair = {
    res = "res/chars/BHeart/hitair.png",
    dim = {w = 222, h = 141}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = ANIM.Step2(function() return this:spd().y end)},
  hitflr = {
    res = "res/chars/BHeart/hitflr.png",
    dim = {w = 254, h = 69}, pad = {x = 0.5, y = -20},
    frate = 30, nframes = 1, anim = "play"},
  atk = {
    res = "res/chars/BHeart/atk1.png",
    dim = {w = 288, h = 174}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 4, anim = "play"},
  atkalt = {
    res = "res/chars/BHeart/atk2.png",
    dim = {w = 308, h = 174}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 5, anim = "play"},
  atkflr = {
    res = "res/chars/BHeart/atk3.png",
    dim = {w = 252, h = 178}, pad = {x = 0.5, y = 1},
    frate = 5, nframes = 5, anim = "play"},
}

return actor