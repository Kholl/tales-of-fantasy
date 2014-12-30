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
  faction = "elven",
  hp =  75, hpmax =  75,
  mp = 125, mpmax = 125,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 100, z = 100},
      rng = {min = 60},
      ep = 1,
    },
    
    run = {
      spd = {x = 200},
      rng = {min = 160},
      ep = 1,
    },
    
    blk = {
      rng = {min = 0, max = 40},
      ep = 6,
    },

    atk = {
      hit = {[5] = {box = {x = 0, y = 0, w = 82, h = 82}}},
      rng = {min = 0, max = 82},
      ep = 120,
    },
    
    jmp = {
      rng = {min = 120, max = 140},
      spd = {x = 100, y = -220},
      ep = 120,
    },
    
    atkjmp = {
      hit = {[3] = {box = {x = 0, y = 0, w = 66, h = 96}}},
      rng = {min = 0, max = 66},
      ep = 0,
    },
    
    atkalt = {
      hit = {[5] = {box = {x = 0, y = 0, w = 82, h = 96}, force = {x = 100, y = -200}}},
      rng = {min = 0, max = 82},
      ep = 120,
    },

    atkrun = {
      hit = {[3] = {box = {x = 0, y = 0, w = 80, h = 92}, force = {x = 180, y = -220}}},
      rng = {min = 0, max = 80},
      ep = 120,
    },
    
    atkflr = {
      spd = {x = 300},
      rng = {min = 40, max = 120},
      ep = 120,
    },
    
    atkup = {
      spd = {x = -100, y = -220},
      hit = {[1] = {box = {x = 0, y = 0, w = 60, h = 95}, force = {x = 0, y = -300}}},
      rng = {min = 0, max = 60},
      ep = 165,
    },
    
    atkrnd = {
      hit = {
        [1] = {box = {x = -81, y = 13, w = 81, h = 69}, force = {x = 100, y = -200}},
        [3] = {box = {x =   0, y = 13, w = 81, h = 69}, force = {x = 100, y = -200}},
      },
      rng = {min = 0, max = 81},
      ep = 120,
    },
    
    atksq1 = {
      hit = {[4] = {box = {x = 0, y = 0, w = 100, h = 73}}},
      rng = {min = 0, max = 100},
      ep = 0,
    },
    
    atksq2 = {
      hit = {[3] = {box = {x = 0, y = 14, w = 105, h = 51}}},
      rng = {min = 0, max = 105},
      ep = 0,
    },
  
    atksq3 = {
      hit = {[5] = {box = {x = 0, y = 0, w = 111, h = 85}, force = {x = 180, y = -220}}},
      rng = {min = 0, max = 111},
      ep = 0,
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
    dim = {w = 164, h = 82}, pad = {x = 0.5, y = 1},
    frate = {2, [8] = 6}, nframes = 8, anim = "play"},
  atkjmp = {
    res = "res/chars/elf/atkjmp.png",
    dim = {w = 132, h = 96}, pad = {x = 0.5, y = 1},
    frate = 2.2, nframes = 7, anim = "play"},
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
  hitalt = {
    res = "res/chars/elf/hitalt.png",
    dim = {w = 57, h = 62}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  hithvy = {
    res = "res/chars/elf/hithvy.png",
    dim = {w = 130, h = 51}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 1, anim = "idle"},
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
    dim = {w = 100, h = 65}, pad = {x = 0.5, y = 1},
    frate = {2, 2, 8}, nframes = 3, anim = "play"},
  atkalt = {
    res = "res/chars/elf/atk2h.png",
    dim = {w = 164, h = 96}, pad = {x = 0.5, y = -13},
    frate = {2.5, [9] = 7.5}, nframes = 9, anim = "play"},
  atkrun = {
    res = "res/chars/Elf/atkrun.png",
    dim = {w = 160, h = 92}, pad = {x = 0.5, y = 1},
    frate = {2, [5] = 10}, nframes = 5, anim = "play"},
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
  atksq1 = {
    res = "res/chars/Elf/atksq1.png",
    dim = {w = 200, h = 73}, pad = {x = 0.5, y = 1},
    frate = {2, [9] = 6}, nframes = 9, anim = "play"},
  atksq2 = {
    res = "res/chars/Elf/atksq2.png",
    dim = {w = 210, h = 65}, pad = {x = 0.5, y = 1},
    frate = {2, [6] = 6}, nframes = 6, anim = "play"},
  atksq3 = {
    res = "res/chars/Elf/atksq3.png",
    dim = {w = 222, h = 85}, pad = {x = 0.5, y = 1},
    frate = {2, [8] = 6}, nframes = 8, anim = "play"},
}

return actor