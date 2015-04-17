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
actor.pmap = Asset["high elf pal"]

actor.info = {
  faction = "helf",
  hp = 100, hpmax = 100,
  mp =   0, mpmax =   0,
  dir = {x = 0, z = 0},
}

actor.states = {
  std = {
    res = "game/chars/delf/std.png",
    dim = {w = 120, h = 72},
    frate = 12,
    nframes = 2,
    anim = "loop"},
  wlk = {
    res = "game/chars/delf/wlk.png",
    dim = {w = 64, h = 62},
    frate = 3,
    nframes = 8,
    anim = "loop"},
  jmp = {
    res = "game/chars/delf/jmp.png",
    rad = 0,
    dim = {w = 47, h = 74},
    frate = 0,
    nframes = 1,
    anim = "idle"},
  hit = {
    res = "game/chars/delf/hit.png",
    dim = {w = 60, h = 68},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hitair = {
    res = "game/chars/delf/hitair.png",
    rad = 0,
    dim = {w = 81, h = 42},
    frate = 0,
    nframes = 2,
    anim = Anim.Air2()},
  hitflr = {
    res = "game/chars/delf/hitflr.png",
    dim = {w = 88, h = 22},
    frate = 30,
    nframes = 1,
    anim = "play"},
  die = {
    res = "game/chars/delf/hitflr.png",
    rad = 0,
    dim = {w = 88, h = 22}},
  hitalt = {
    res = "game/chars/delf/hitalt.png",
    dim = {w = 100, h = 75},
    frate = 4,
    nframes = 2,
    anim = "play"},
  atk = {
    res = "game/chars/delf/atk1.png",
    dim = {w = 154, h = 89},
    pad = {x = 0.5, y = -5},
    frate = 3,
    nframes = 7,
    anim = "play"},
  atksq1 = {
    res = "game/chars/delf/atk2.png",
    dim = {w = 188, h = 81},
    pad = {x = 0.5, y = -1},
    frate = 3,
    nframes = 4,
    anim = "play"},
  atkalt = {
    res = "game/chars/delf/atk3.png",
    dim = {w = 211, h = 66},
    pad = {x = 0.5, y = -1},
    frate = {3, [4] = 6},
    nframes = 4,
    anim = "play"},
  atkjmp = {
    res = "game/chars/delf/atkair.png",
    rad = 0,
    dim = {w = 121, h = 79},
    pad = {x = 0.5, y = -1},
    frate = 6,
    nframes = 3,
    anim = "play"},
}

actor.rules = {
  wlk = {
    ActorScript.move{x = 100, z = 100},
  },
  atk = {
    ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 5},
    std = ActorScript.isEnded,
  },
  hit = {
    hitair = -SceneScript.isFloor,
    std = ActorScript.isEnded,
  },
  hitair = {
    hitflr = SceneScript.isFloor,
  },
  hitflr = {
    std = ActorScript.isEnded,
    die = ActorScript.isDied,
  },
  atkalt = {
    ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 10},
    std = ActorScript.isEnded,    
  },
  atksq1 = {
    ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 8, force = {x = 80}},
    std = ActorScript.isEnded,
  },
  jmp = {
    std = SceneScript.isFloor,
  },
  jmpatk = {
    ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 10},
    jmp = ActorScript.isEnded,
    std = SceneScript.isFloor,
  },  
}

actor.autorules = {
  std = {
    -ActorScript.isTarget / ActorScript.find,
    wlk = ActorScript.isTarget,
    atk = ActorScript.isTarget ^ ActorScript.isHit("atk"),
    atkalt = ActorScript.isTarget ^ ActorScript.isHit("atkalt"),
    jmp = (ActorScript.isTarget ^ ActorScript.isRange("x", 140, 120)) / ActorScript.move{x = 100, y = -240},
  },
  
  wlk = {
    std = -ActorScript.isTarget,
    wlk = ActorScript.isTarget,
    atk = ActorScript.isTarget ^ ActorScript.isHit("atk"),
    atkalt = ActorScript.isTarget ^ ActorScript.isHit("atkalt") ^ Script.random(2),
    jmp = (ActorScript.isTarget ^ ActorScript.isRange("x", 140, 120)) / ActorScript.move{x = 100, y = -240},
  },
  
  atk = {
    atksq1 = ActorScript.isEnded ^ ActorScript.isTarget ^ ActorScript.isHit("atksq1"),
  },
  
  jmp = {
    atkjmp = ActorScript.isTarget ^ ActorScript.isHit("atkjmp"),
  },
}

actor.keybrules = {
  std = {
    atkalt = ActorScript.isKey{"a[rl]>"},
    jmp = ActorScript.isKey{"b[rlud]*>"} / ActorScript.move{x = 100, y = -220},
    wlk = ActorScript.isKey{"[rlud]+>"},
    atk = ActorScript.isKey{"a>"},
  },
  wlk = {
    jmp = ActorScript.isKey{"[rlud]*b>"} / ActorScript.move{x = 100, y = -200},
    wlk = ActorScript.isKey{"[rlud]+>"},
    std = -ActorScript.isKey(),
  },
  atk = {
    atksq1 = ActorScript.isKey{"a>a>"} ^ ActorScript.isEnded,
  },
  jmp = {
    jmpatk = ActorScript.isKey{"a[rlud]*>"},
  },
}

return actor