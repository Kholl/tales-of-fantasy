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
actor.box = {w = 120, h = 135}

actor.info = {
  faction = "demon",
  hp = 750, hpmax = 750,
  mp = 250, mpmax = 250,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 60, z = 60},
      rng = {min = 85+25},
      ep = 1,
    },
        
    atk = {
      hit = {[3] = {box = {x = 25, y = 42, w = 85, h = 48}, force = {x = 240, y = -40}}},
      rng = {min = 25, max = 85+25},
      ep = 240,
    },
--[[        
    atkflr = {
      hit = {},
      rng = {min = 90, max = 120},
    },
]]--
  },
}

actor.states = {
  std = {
    res = "res/chars/DWarrior/std.png",
    dim = {w = 147, h = 144}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 1, anim = "idle"},
  wlk = {
    res = "res/chars/DWarrior/wlk.png",
    dim = {w = 161, h = 153}, pad = {x = 0.5, y = 1},
    frate = 5, nframes = 7, anim = "loop"},
  hit = {
    res = "res/chars/DWarrior/hit.png",
    dim = {w = 176, h = 136}, pad = {x = 0.5, y = 1},
    frate = 12, nframes = 1, anim = "play"},
  hitair = {
    res = "res/chars/DWarrior/hitair.png",
    dim = {w = 206, h = 104}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = ANIM.Step2(function() return this:spd().y end)},
  hitflr = {
    res = "res/chars/DWarrior/hitflr.png",
    dim = {w = 200, h = 78}, pad = {x = 0.5, y = -20},
    frate = 30, nframes = 1, anim = "play"},
  atk = {
    res = "res/chars/DWarrior/atk.png",
    dim = {w = 220, h = 145}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 5, anim = "play"},
  atkflr = {
    res = "res/chars/DWarrior/atkflr.png",
    dim = {w = 190, h = 140}, pad = {x = 0.5, y = 1},
    frate = 5, nframes = 3, anim = "play"},
}

return actor