--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

ANIM = {
  Jump = function(sprite)
    local k = this:spd().y / this.prof.jmp
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
actor.state = "std"
actor.box = {w = 30, h = 54}

actor.info = {
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 80, z = 40},
      rng = {x = {min = 60}},
    },
    atk = {
      hit = {[2] = {box = {x = 23, y = 32, w = 37, h = 14}, force = {x = 120, y = 0, z = 0}}},
      rng = {
        x = {min = 23, max = 23+36},
        y = {min = 0, max = 30},
        z = {min = 0, max = 10},
      },
    },
    
    jmp = {
      spd = {y = -140},
      rng = {x = {min = 120}},
    },
  }
}

actor.states = {
  std = {
    res = "res/chars/orc/std.png",
    dim = {w = 61, h = 60}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 1, anim = "idle"},
  wlk = {
    res = "res/chars/orc/wlk.png",
    dim = {w = 61, h = 60}, pad = {x = 0.5, y = 1},
    frate = 6, nframes = 6, anim = "loop"},
  atk = {
    res = "res/chars/orc/atk.png",
    dim = {w = 126, h = 63}, pad = {x = 0.5, y = 1},
    frate = 6, nframes = 3, anim = "play"},
  jmp = {
    res = "res/chars/orc/jmp.png",
    dim = {w = 65, h = 66}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 3, anim = ANIM.Jump},
  hit = {
    res = "res/chars/orc/hit.png",
    dim = {w = 89, h = 53}, pad = {x = 0.5, y = 1},
    frate = 12, nframes = 1, anim = "play"},
  hitair = {
    res = "res/chars/orc/hitair.png", 
    dim = {w = 89, h = 53}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = ANIM.Step2(function() return this:spd().y end)},
  hitflr = {
    res = "res/chars/orc/hitflr.png",
    dim = {w = 89, h = 53}, pad = {x = 0.5, y = 1},
    frate = 30, nframes = 1, anim = "play"},
}

return actor