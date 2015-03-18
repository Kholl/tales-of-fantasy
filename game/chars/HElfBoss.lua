--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 24, h = 76}
actor.rad = 12
actor.pmap = Game.Assets["high elf pal"]

actor.states = {
  std = {
    res = "game/chars/delfboss/std.png",
    dim = {w = 80, h = 78},
    frate = 0,
    nframes = 1,
    anim = "idle"},
  wlk = {
    res = "game/chars/delfboss/wlk.png",
    dim = {w = 83, h = 78},
    frate = 3,
    nframes = 8,
    anim = "loop"},
  atk = {
    res = "game/chars/delfboss/atk1.png",
    dim = {w = 212, h = 80},
    frate = 3,
    nframes = 4,
    anim = "play"},
  atkalt = {
    res = "game/chars/delfboss/atk2.png",
    dim = {w = 150, h = 81},
    pad = {x = 0.5, y = -1},
    frate = 3,
    nframes = 5,
    anim = "play"},
  jmp = {
    res = "game/chars/delfboss/jmp.png",
    rad = 0,
    dim = {w = 60, h = 101},
    frate = 0,
    nframes = 2,
    anim = Game.Anim.Air2(this)},
  hit = {
    res = "game/chars/delfboss/hit.png",
    dim = {w = 96, h = 77},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hitair = {
    res = "game/chars/delfboss/hitair.png",
    rad = 0,
    dim = {w = 116, h = 46},
    frate = 0,
    nframes = 2,
    anim = Game.Anim.Air2(this)},
  hitflr = {
    res = "game/chars/delfboss/hitflr.png",
    dim = {w = 123, h = 31},
    frate = 30,
    nframes = 1,
    anim = "play"},
  die = {
    res = "game/chars/delfboss/hitflr.png",
    rad = 0,
    dim = {w = 123, h = 31}},
  hitalt = {
    res = "game/chars/delfboss/hitalt.png",
    dim = {w = 100, h = 75},
    frate = 4,
    nframes = 2,
    anim = "play"},
}

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
      dmg = 8,
      hit = {[3] = {box = {x = 0, y = 36, w = 106, h = 44}}},
      rng = {min = 0, max = 106},
      ep = 160,
    },
        
    atkalt = {
      dmg = 12,
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
    die = {evade = true},
  },
}

return actor