--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.state = "std"
actor.box = {w = 30, h = 54}
actor.rad = 15

actor.info = {
  faction = "orc",
  hp =  25, hpmax =  25,
  mp =   0, mpmax =   0,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 80, z = 80},
      rng = {min = 63},
      ep = 1,
    },
    
    atk = {
      dmg = 1, -- 6
      hit = {[2] = {box = {x = 0, y = 0, w = 63, h = 63}}},
      rng = {min = 0, max = 63},
      ep = 180,
    },
    
    jmp = {
      rng = {min = 120},
      spd = {x = 80, y = -200},
      ep = 180,
    },
    
    hitflr = {evade = true},
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
    frate = 0, nframes = 3, anim = Game.Anim.Air(this)},
  hit = {
    res = "res/chars/orc/hit.png",
    dim = {w = 89, h = 53}, pad = {x = 0.5, y = 1},
    frate = 12, nframes = 1, anim = "play"},
  hitair = {
    res = "res/chars/orc/hitair.png", 
    dim = {w = 89, h = 53}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = Game.Anim.Air2(this)},
  hitflr = {
    res = "res/chars/orc/hitflr.png",
    dim = {w = 89, h = 53}, pad = {x = 0.5, y = 1},
    frate = 30, nframes = 1, anim = "play"},
}

return actor