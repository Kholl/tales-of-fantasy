--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 28, h = 78}
actor.rad = 14
actor.mass = 1
actor.pmap = Asset["high elf pal"]

actor.info = {
  faction = "helf",
  hp = 300, hpmax = 300,
  mp = 100, mpmax = 100,
  dir = {x = 0, z = 0},
}

actor.states = {
  std = {
    res = "game/chars/telarin/std.png",
    dim = {w = 100, h = 80},
    frate = 10,
    nframes = 2,
    anim = "loop"},
  wlk = {
    res = "game/chars/telarin/wlk.png",
    dim = {w = 100, h = 114},
    frate = 3,
    nframes = 8,
    anim = "loop"},
  atk = {
    res = "game/chars/telarin/atk1.png",
    dim = {w = 252, h = 81}, pad = {x = 100, y = 1},
    frate = 2.5,
    nframes = 7,
    anim = "play"},
  atkalt = {
    res = "game/chars/telarin/atk2.png",
    dim = {w = 200, h = 90}, pad = {x = 0.5, y = -5},
    frate = 3,
    nframes = 4,
    anim = "play"},
  atkjmp = {
    res = "game/chars/telarin/atkair.png",
    rad = 0,
    dim = {w = 200, h = 122},
    frate = 2.5,
    nframes = 7,
    anim = "play"},
  jmp = {
    res = "game/chars/telarin/jmp.png",
    rad = 0,
    dim = {w = 106, h = 109},
    frate = 0,
    nframes = 3,
    anim = Anim.Air3(60)},
  hit = {
    res = "game/chars/telarin/hit.png",
    dim = {w = 132, h = 84},
    frate = 4,
    nframes = 2,
    anim = "play"},
  hitair = {
    res = "game/chars/telarin/hitair.png",
    rad = 0,
    dim = {w = 111, h = 77},
    frate = 0,
    nframes = 2,
    anim = Anim.Air2()},
  hitflr = {
    res = "game/chars/telarin/hitflr.png",
    dim = {w = 125, h = 52},
    frate = {[1] = 2, [2] = 28},
    nframes = 2,
    anim = "play"},
  die = {
    res = "game/chars/telarin/hitflr.png",
    rad = 0,
    dim = {w = 125, h = 52},
    frate = {[1] = 2, [2] = 28},
    nframes = 2,
    anim = "play"},
  hithvy = {
    res = "game/chars/telarin/hithvy.png",
    dim = {w = 158, h = 111},
    frate = 2,
    nframes = 3,
    anim = "play"},
}

actor.rules = {
  wlk = {
    ActorScript.move{x = 90, z = 90},
  },
  atk = {
    ActorScript.isFrame(6) / ActorScript.hitAll{dmg = 20},
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
    ActorScript.isFrame(3) / ActorScript.hitAll{dmg = 24},
    std = ActorScript.isEnded,    
  },
  jmp = {
    std = SceneScript.isFloor,
  },
  jmpatk = {
    ActorScript.isFrame(6) / ActorScript.hitAll{dmg = 24},
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
  jmp = {
    jmpatk = ActorScript.isKey{"a[rlud]*>"},
  },
}

return actor