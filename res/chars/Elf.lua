--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.state = "std"
actor.box = {w = 24, h = 68}

actor.prof = {
  spd = 100,
  jmp = -220,
  state = {
    atk = {
      hit = {
        frm = 5,
        box = {x = 20, y = 38, w = 47, h = 12},
        force = {x = 100, y = 0, z = 0},
      },
      rng = {
        x = {min = 20, max = 20+47},
        y = {min = 0, max = 30},
        z = {min = 0, max = 10},
      },
    },
    
    jmp = {
      rng = 150
    },
    
    atkjmp = {
      hit = {
        frm = 3,
        box = {x = 31, y = 57, w = 35, h = 18},
        force = {x = 120, y = -40, z = 0},
      },
      rng = {
        x = {min = 31, max = 31+35},
        y = {min = 0, max = 30},
        z = {min = 0, max = 10},
      },
    },
    
    atk1 = {
      hit = {
        frm = 5,
        box = {x = 26, y = 32+13, w = 56, h = 14},
        force = {x = 160, y = -40, z = 0},
      },
      rng = {
        x = {min = 26, max = 26+56},
        y = {min = 0, max = 30},
        z = {min = 0, max = 10},
      },
    },
    
    atk2 = {
      hit = {
        frm = 3,
        box = {x = 44, y = 59+13, w = 36, h = 17},
        force = {x = 220, y = -40, z = 0},
      },
      rng = {
        x = {min = 44, max = 44+36},
        y = {min = 0, max = 30},
        z = {min = 0, max = 10},
      },
    },
  }
}

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

actor.states = {
  std = {
    res = "res/chars/elf/std.png",
    dim = {w = 59, h = 69}, pad = {x = 0.5, y = 1},
    frate = 8, nframes = 3, anim = "loop"},
  wlk = {
    res = "res/chars/elf/wlk.png",
    dim = {w = 50, h = 68}, pad = {x = 0.5, y = 1},
    frate = 2, nframes = 12, anim = "loop"},
  atk = {
    res = "res/chars/elf/atk.png",
    dim = {w = 134, h = 82}, pad = {x = 0.5, y = 1},
    frate = 2, nframes = 8, anim = "play"},
  atkjmp = {
    res = "res/chars/elf/atkjmp.png",
    dim = {w = 132, h = 96}, pad = {x = 0.5, y = 1},
    frate = 2, nframes = 5, anim = "play"},
  jmp = {
    res = "res/chars/elf/jmp.png",
    dim = {w = 62, h = 98}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 8, anim = ANIM.Jump},
  hit = {
    res = "res/chars/elf/hit.png",
    dim = {w = 48, h = 68}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  hitair = {
    res = "res/chars/elf/hitair.png",
    dim = {w = 110, h = 49}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 4, anim = ANIM.Step3(60, function() return this:spd().y end)},
  hitflr = {
    res = "res/chars/elf/hitflr.png",
    dim = {w = 110, h = 49}, pad = {x = 0.5, y = 1},
    frate = 30, nframes = 1, anim = "play"},
  run = {
    res = "res/chars/elf/run.png",
    dim = {w = 116, h = 64}, pad = {x = 0.5, y = 1},
    frate = 2, nframes = 12, anim = "loop"},
  runend = {
    res = "res/chars/Elf/runend.png",
    dim = {w = 76, h = 62}, pad = {x = 0.5, y = 1},
    frate = 12, nframes = 1, anim = "play"},
  atk1 = {
    res = "res/chars/elf/atk1.png",
    dim = {w = 164, h = 96}, pad = {x = 0.5, y = -13},
    frate = 2, nframes = 9, anim = "play"},
  atk2 = {
    res = "res/chars/Elf/atk2.png",
    dim = {w = 160, h = 92}, pad = {x = 0.5, y = 1},
    frate = {2, 2, 2, 2, 12}, nframes = 5, anim = "play"},
}

return actor