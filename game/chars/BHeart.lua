--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.pad = {x = 0.5, y = 1}
actor.box = {w = 82, h = 144}
actor.rad = 41
actor.mass = 12

actor.info = {
  faction = "demon",
  massive = true,
  hp = 500, hpmax = 500,
  mp = 500, mpmax = 500,
  ep =   0, epmax = 300,
  dir = {x = 0, z = 0},
}

actor.states = {
  std = {
    res = "game/chars/bheart/std.png",
    dim = {w = 127, h = 177},
    frate = 4,
    nframes = 8,
    anim = "loop"},
  wlk = {
    res = "game/chars/bheart/wlk.png",
    dim = {w = 150, h = 168},
    frate = 3,
    nframes = 12,
    anim = "loop"},
  hit = {
    res = "game/chars/bheart/hit.png",
    dim = {w = 200, h = 167},
    frate = 4,
    nframes = 3,
    anim = "play"},
  hitair = {
    res = "game/chars/bheart/hitair.png",
    dim = {w = 222, h = 141},
    frate = 0,
    nframes = 2,
    anim = Anim.Air2()},
  hitflr = {
    res = "game/chars/bheart/hitflr.png",
    dim = {w = 254, h = 69},
    pad = {x = 0.5, y = -20},
    frate = 30,
    nframes = 1,
    anim = "play"},
  die = {
    res = "game/chars/bheart/hitflr.png",
    rad = 0,
    dim = {w = 254, h = 69},
    pad = {x = 0.5, y = -20}},
  atk = {
    res = "game/chars/bheart/atk1.png",
    dim = {w = 288, h = 174},
    frate = 4,
    nframes = 4,
    anim = "play"},
  atkalt = {
    res = "game/chars/bheart/atk2.png",
    dim = {w = 308, h = 174},
    frate = 3,
    nframes = 5,
    anim = "play"},
  atkflr = {
    res = "game/chars/bheart/atk3.png",
    dim = {w = 252, h = 178},
    frate = 5,
    nframes = 5,
    anim = "play"},
}

actor.rules = {
  atk = {
    ActorScript.isFrame(2) / ActorScript.hitAll{dmg = 20},
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
    ActorScript.isFrame(3) / ActorScript.hitAll{dmg = 15},
    std = ActorScript.isEnded,
  },
}

actor.autorules = {
  std = {
    -ActorScript.isTarget / ActorScript.find,
    wlk = ActorScript.isTarget,
    atk = ActorScript.isTarget ^ ActorScript.isHit("atk"),
  },
  
  wlk = {
    ActorScript.move{spd = {x = 90, z = 90}},
    std = -ActorScript.isTarget,
    wlk = ActorScript.isTarget ^ -ActorScript.isHit("atk"),
    atk = ActorScript.isTarget ^ ActorScript.isHit("atk"),
  },
}

actor.keybrules = {
  std = {
    atkalt = ActorScript.isKey{"a[rl]>"},
    wlk = ActorScript.isKey{"[rlud]+>"},
    atk = ActorScript.isKey{"a>"},    
  },
  wlk = {
    wlk = ActorScript.isKey{"[rlud]+>"}  / ActorScript.move{spd = {x = 90, z = 90}},
    std = -ActorScript.isKey(),
  },
}

return actor