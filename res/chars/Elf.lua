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
      rng = {min = 67},
    },
    
    run = {
      spd = {x = 200, z = 100},
      rng = {min = 160},
    },
    
    blk = {
      rng = {min = 0, max = 40},
    },

    atk = {
      hit = {[5] = {box = {x = 20, y = 38, w = 47, h = 12}, force = {x = 100}}},
      rng = {min = 20, max = 20+46},
    },
    
    jmp = {
      rng = {min = 160},
      spd = {x = 100, y = -220},
    },
    
    atkjmp = {
      hit = {[3] = {box = {x = 31, y = 57, w = 35, h = 18}, force = {x = 120, y = 10}}},
      rng = {min = 31, max = 31+34},
    },
    
    atk2h = {
      hit = {[5] = {box = {x = 26, y = 32+13, w = 56, h = 14}, force = {x = 200}}},
      rng = {min = 26, max = 26+55},
    },

    atkrun = {
      hit = {[3] = {box = {x = 44, y = 59+13, w = 36, h = 17}, force = {x = 220, y = -40}}},
      rng = {min = 44, max = 44+35},
    },
    
    atkflr = {
      spd = {x = 300},
      hit = {[1] = {box = {x = 0, y = 17, w = 53, h = 22}, force = {y = -20}}},
      rng = {min = 0, max = 53},
    },
    
    atkup = {
      spd = {x = -100, y = -220},
      hit = {[1] = {box = {x = 4, y = 0, w = 45, h = 81}, force = {x = 0, y = -300}}},
      rng = {min = 4, max = 49},
    },
    
    atkrnd = {
      hit = {
        [1] = {box = {x = -71, y = 14, w = 38, h = 38}, force = {x = 220, y = -40}},
        [3] = {box = {x =  43, y = 14, w = 38, h = 38}, force = {x = 220, y = -40}},
      },
      rng = {min = 43, max = 81},
    },
  },
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
  blk = {
    res = "res/chars/elf/blk.png",
    dim = {w = 52, h = 67}, pad = {x = 0.5, y = 1},
    frate = 2, nframes = 12, anim = "idle"},
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
  atkflr = {
    res = "res/chars/Elf/atkflr.png",
    dim = {w = 106, h = 41}, pad = {x = 0.5, y = 1},
    frate = {8, 16}, nframes = 2, anim = "play"},
  atkup = {
    res = "res/chars/Elf/atkup.png",
    dim = {w = 120, h = 95}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 4, anim = "play"},
  atkrnd = {
    res = "res/chars/Elf/atkrnd.png",
    dim = {w = 162, h = 82}, pad = {x = 0.5, y = 1},
    frate = 2.5, nframes = 5, anim = "play"},
}

return actor