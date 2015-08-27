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

actor.info = {
  faction = "demon",
  massive = true,
  hp = 750, hpmax = 750,
  mp = 250, mpmax = 250,
  dir = {x = 0, z = 0},
}

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
    anim = Anim.Air2()},
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

actor.rules = {
  wlk = {
    Script.move{x = 60, z = 60},
  },
  atk = {
    Script.isFrame(3) / Script.hitAll{dmg = 25, force = {x = 180, y = -220}},
    std = Script.isEnded,
  },
  hit = {
    hitair = -Script.isFloor,
    std = Script.isEnded,
  },
  hitair = {
    hitflr = Script.isFloor,
  },
  hitflr = {
    std = Script.isEnded,
    die = Script.isDied,
  },
}

actor.autorules = {
  std = {
    -Script.isTarget / Script.find,
    wlk = Script.isTarget,
    atk = Script.isTarget ^ Script.isHit("atk"),
  },
  
  wlk = {
    std = -Script.isTarget,
    wlk = Script.isTarget,
    atk = Script.isTarget ^ Script.isHit("atk"),
  },
}

actor.keybrules = {
  std = {
    atkalt = Script.isKey{"a[rl]>"},
    wlk = Script.isKey{"[rlud]+>"},
    atk = Script.isKey{"a>"},    
  },
  wlk = {
    wlk = Script.isKey{"[rlud]+>"}  / Script.move{x = 90, z = 90},
    std = -Script.isKey(),
  },
}

return actor