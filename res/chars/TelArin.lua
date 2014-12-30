--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

ANIM = {
  Jump = function(sprite)
    local k = this:spd().y / this.info.state.jmp.spd.y
    return (sprite.data.nframes) * (1 - k) * 0.5
  end,
  
  Step2 = function(func)
    return function(sprite)
      if func() < 0 then return 0 else return 1 end
    end
  end,
  
  Step3 = function(thold, func)
    return function(sprite)
      local value = func()
      
      if value < -thold then return 0
      elseif value > thold then return 2
      else return 1
      end
    end
  end,
}

actor = {}
actor.action = false
actor.state = "std"
actor.box = {w = 24, h = 68}

actor.info = {
  faction = "elven2",
  hp =  75, hpmax =  75,
  mp = 125, mpmax = 125,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 100, z = 100},
      rng = {min = 67},
      ep = 1,
    },

    atk = {
      hit = {[5] = {box = {x = 20, y = 38, w = 47, h = 12}, force = {x = 100}}},
      rng = {min = 20, max = 20+46},
      ep = 120,
    },
    
    jmp = {
      rng = {min = 160},
      spd = {x = 100, y = -220},
      ep = 165,
    },
    
    atkjmp = {
      hit = {[3] = {box = {x = 31, y = 57, w = 35, h = 18}, force = {x = 120, y = 10}}},
      rng = {min = 31, max = 31+34},
      ep = 0,
    },
    
    atkalt = {
      hit = {[5] = {box = {x = 26, y = 32+13, w = 56, h = 14}, force = {x = 200}}},
      rng = {min = 26, max = 26+55},
      ep = 165,
    },
  },
}

actor.states = {
  std = {
    res = "res/chars/telarin/std.png",
    dim = {w = 100, h = 80}, pad = {x = 0.5, y = 1},
    frate = 10, nframes = 2, anim = "loop"},
  wlk = {
    res = "res/chars/telarin/wlk.png",
    dim = {w = 100, h = 114}, pad = {x = 0.5, y = 1},
    frate = 2, nframes = 8, anim = "loop"},
  atk = {
    res = "res/chars/telarin/atk1.png",
    dim = {w = 252, h = 81}, pad = {x = 100, y = 1},
    frate = 2.4, nframes = 7, anim = "play"},
  atkalt = {
    res = "res/chars/telarin/atk2.png",
    dim = {w = 200, h = 90}, pad = {x = 0.5, y = -5},
    frate = 3, nframes = 4, anim = "play"},
  atkjmp = {
    res = "res/chars/telarin/atkair.png",
    dim = {w = 200, h = 122}, pad = {x = 0.5, y = 1},
    frate = 2.2, nframes = 7, anim = "play"},
  jmp = {
    res = "res/chars/telarin/jmp.png",
    dim = {w = 106, h = 109}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 3, anim = ANIM.Step3(60, function() return this:spd().y end)},
  hit = {
    res = "res/chars/telarin/hit.png",
    dim = {w = 132, h = 84}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  hitair = {
    res = "res/chars/telarin/hitair.png",
    dim = {w = 111, h = 77}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = ANIM.Step2(function() return this:spd().y end)},
  hitflr = {
    res = "res/chars/telarin/hitflr.png",
    dim = {w = 125, h = 52}, pad = {x = 0.5, y = 1},
    frate = {[1] = 2, [2] = 28}, nframes = 2, anim = "play"},
  hithvy = {
    res = "res/chars/telarin/hithvy.png",
    dim = {w = 158, h = 111}, pad = {x = 0.5, y = 1},
    frate = 2, nframes = 3, anim = "play"},
}

return actor