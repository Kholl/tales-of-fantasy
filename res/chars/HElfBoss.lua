--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.box = {w = 24, h = 76}
actor.rad = 12
actor.pmap = Game.assets["high elf pal"]

actor.info = {
  faction = "helf",
  hp = 125, hpmax = 125,
  mp =  75, mpmax =  75,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  
  state = {
    wlk = {
      spd = {x = 100, z = 100},
      rng = {min = 75},
      ep = 1,
    },

    atk = {
      dmg = 4, -- 12
      hit = {[3] = {box = {x = 0, y = 36, w = 106, h = 44}}},
      rng = {min = 0, max = 106},
      ep = 160,
    },
        
    atkalt = {
      dmg = 5, -- 15
      hit = {[4] = {box = {x = 0, y = 27, w = 75, h = 54}, force = {x = 140, y = -160}}},
      rng = {min = 0, max = 75},
      ep = 160,
    },
    
    jmp = {
      rng = {min = 120, max = 140},
      spd = {x = 120, y = -240},
      ep = 120,
    },
    
    hitflr = {evade = true},
  },
}

actor.states = {
  std = {
    res = "res/chars/delfboss/std.png",
    dim = {w = 80, h = 78}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 1, anim = "idle"},
  wlk = {
    res = "res/chars/delfboss/wlk.png",
    dim = {w = 83, h = 78}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 8, anim = "loop"},
  atk = {
    res = "res/chars/delfboss/atk1.png",
    dim = {w = 212, h = 80}, pad = {x = 0.5, y = 1},
    frate = 3, nframes = 4, anim = "play"},
  atkalt = {
    res = "res/chars/delfboss/atk2.png",
    dim = {w = 150, h = 81}, pad = {x = 0.5, y = -1},
    frate = 3, nframes = 5, anim = "play"},
  jmp = {
    res = "res/chars/delfboss/jmp.png",
    dim = {w = 60, h = 101}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = Game.Anim.Air2(this)},
  hit = {
    res = "res/chars/delfboss/hit.png",
    dim = {w = 96, h = 77}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
  hitair = {
    res = "res/chars/delfboss/hitair.png",
    dim = {w = 116, h = 46}, pad = {x = 0.5, y = 1},
    frate = 0, nframes = 2, anim = Game.Anim.Air2(this)},
  hitflr = {
    res = "res/chars/delfboss/hitflr.png",
    dim = {w = 123, h = 31}, pad = {x = 0.5, y = 1},
    frate = 30, nframes = 1, anim = "play"},
  hitalt = {
    res = "res/chars/delfboss/hitalt.png",
    dim = {w = 100, h = 75}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 2, anim = "play"},
}

return actor