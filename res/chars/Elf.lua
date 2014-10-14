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
  hit = {
    frm = 5,
    box = {x = 20, y = 38, w = 47, h = 12},
    force = {x = 120, y = -220, z = 0},
  },
  rng = {
    x = {min = 20, max = 20+47},
    y = {min = 0, max = 30},
    z = {min = 0, max = 10},
  },
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
  std = {res = "res/chars/elf/std.png", dim = {w = 59, h = 69},
         frate = 8, nframes = 3, anim = "loop"},
  wlk = {res = "res/chars/elf/wlk.png", dim = {w = 50, h = 68},
         frate = 3, nframes = 12, anim = "loop"},
  atk = {res = "res/chars/elf/atk1.png", dim = {w = 134, h = 82},
         frate = 2, nframes = 8, anim = "play"},
  jmp = {res = "res/chars/elf/jmp.png", dim = {w = 62, h = 98},
         frate = 0, nframes = 8, anim = ANIM.Jump},
  hit = {res = "res/chars/elf/hit.png", dim = {w = 48, h = 68},
         frate = 6, nframes = 2, anim = "play"},
  hitair = {res = "res/chars/elf/hitair.png", dim = {w = 110, h = 49},
            frate = 0, nframes = 4, anim = ANIM.Step3(60, function() return this:spd().y end)},
  hitflr = {res = "res/chars/elf/hitflr.png", dim = {w = 110, h = 49},
            frate = 30, nframes = 1, anim = "play"},
}

return actor