--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.state = "std"
actor.box = {w = 30, h = 54}

actor.prof = {
  
  spd = 60,
  jmp = -140,
  spdjmp = 120,
  hit = {
    frm = 2,
    box = {x = 23, y = 32, w = 37, h = 14},
    force = {x = 0, y = 0, z = 0}, --120, y = 0, z = 0},
  },
  rng = {
    x = {min = 23, max = 80+50},
    y = {min = 0, max = 30},
    z = {min = 0, max = 10},
    jmp = 200,
  },
}

actor.states = {
  std = {res = "res/chars/orc/std.png", dim = {w = 61, h = 60},
         frate = 0, nframes = 1, anim = "idle"},
  wlk = {res = "res/chars/orc/wlk.png", dim = {w = 61, h = 60},
         frate = 6, nframes = 6, anim = "loop"},
  atk = {res = "res/chars/orc/atk.png", dim = {w = 126, h = 63},
         frate = 6, nframes = 3, anim = "play"},
  jmp = {res = "res/chars/orc/jmp.png", dim = {w = 65, h = 66},
         frate = 0, nframes = 3,
         anim = function(sprite)
           local k = this:spd().y / this.prof.jmp
           return (sprite.data.nframes) * (1 - k) * 0.5
         end},
  hit = {res = "res/chars/orc/hit.png", dim = {w = 89, h = 53},
         frate = 0, nframes = 3, anim = "idle"},
  hitair = {res = "res/chars/orc/hit.png", dim = {w = 89, h = 53},
            frate = 0, nframes = 3,
            anim = function()
              if this:spd().y < 0 then return 0
              elseif this:spd().y > 0 then return 1
              elseif this:floor() then return 2
              end
            end},
}

return actor