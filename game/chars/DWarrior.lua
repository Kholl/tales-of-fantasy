--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 120, h = 135}
actor.rad = 60
actor.mass = 10

actor.states = {
  std = {
    res = "game/chars/dwarrior/std.png",
    dim = {w = 147, h = 144},
    frate = 0,
    nframes = 1,
    anim = "idle"},
  wlk = {
    res = "game/chars/dwarrior/wlk.png",
    dim = {w = 161, h = 153},
    frate = 5,
    nframes = 7,
    anim = "loop"},
  hit = {
    res = "game/chars/dwarrior/hit.png",
    dim = {w = 176, h = 136},
    frate = 12,
    nframes = 1,
    anim = "play"},
  hitair = {
    res = "game/chars/dwarrior/hitair.png",
    rad = 0,
    dim = {w = 206, h = 104},
    frate = 0,
    nframes = 2,
    anim = Game.Anim.Air2(this)},
  hitflr = {
    res = "game/chars/dwarrior/hitflr.png",
    dim = {w = 200, h = 78},
    pad = {x = 0.5, y = -20},
    frate = 30,
    nframes = 1,
    anim = "play"},
  die = {
    res = "game/chars/dwarrior/hitflr.png",
    rad = 0,
    dim = {w = 200, h = 78},
    pad = {x = 0.5, y = -20}},
  atk = {
    res = "game/chars/dwarrior/atk.png",
    dim = {w = 220, h = 145},
    frate = 4,
    nframes = 5,
    anim = "play"},
  atkflr = {
    res = "game/chars/dwarrior/atkflr.png",
    dim = {w = 190, h = 140},
    frate = 5,
    nframes = 3,
    anim = "play"},
}

actor.info = {
  faction = "demon",
  massive = true,
  hp = 750, hpmax = 750,
  mp = 250, mpmax = 250,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
  state = {
    wlk = {
      spd = {x = 60, z = 60},
      rng = {min = 110},
      ep = 1,
    },
        
    atk = {
      evade = true,
      dmg = 25,
      hit = {[3] = {box = {x = 0, y = 0, w = 110, h = 145}, force = {x = 180, y = -220}}},
      rng = {min = 0, max = 110},
      ep = 300,
    },
    
    hitflr = {evade = true},
    die = {evade = true},
  },
}

return actor