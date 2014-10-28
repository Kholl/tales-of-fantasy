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
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 100, z = 50},
      rng = {x = {min = 67}},
    },
    
    run = {
      spd = {x = 200, z = 100},
      rng = {x = {min = 160}},
    },
    
    atk = {
      hit = {
        frm = 5,
        box = {x = 20, y = 38, w = 47, h = 12},
        force = {x = 100, y = 0, z = 0},
      },
      rng = {
        x = {min = 20, max = 20+46},
        y = {max = 30},
        z = {max = 10},
      },
    },
    
    jmp = {
      rng = {x = {min = 160}},
      spd = {x = 100, y = -220},
    },
    
    atkjmp = {
      hit = {
        frm = 3,
        box = {x = 31, y = 57, w = 35, h = 18},
        force = {x = 120, y = -40, z = 0},
      },
      rng = {
        x = {min = 31, max = 31+34},
        y = {max = 30},
        z = {max = 10},
      },
    },
    
    atk2h = {
      hit = {
        frm = 5,
        box = {x = 26, y = 32+13, w = 56, h = 14},
        force = {x = 160, y = -40, z = 0},
      },
      rng = {
        x = {min = 26, max = 26+55},
        y = {max = 30},
        z = {max = 10},
      },
    },

    atkrun = {
      hit = {
        frm = 3,
        box = {x = 44, y = 59+13, w = 36, h = 17},
        force = {x = 220, y = -40, z = 0},
      },
      rng = {
        x = {min = 44, max = 44+35},
        y = {max = 30},
        z = {max = 10},
      },
    },
  }
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
  atk2h = {
    res = "res/chars/elf/atk2h.png",
    dim = {w = 164, h = 96}, pad = {x = 0.5, y = -13},
    frate = 2.5, nframes = 9, anim = "play"},
  atkrun = {
    res = "res/chars/Elf/atkrun.png",
    dim = {w = 160, h = 92}, pad = {x = 0.5, y = 1},
    frate = {2, 2, 2, 2, 12}, nframes = 5, anim = "play"},
}

return actor