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
    res = "res/chars/bheart/std.png",
    dim = {w = 127, h = 177},
    frate = 4,
    nframes = 8,
    anim = "loop"},
  wlk = {
    res = "res/chars/bheart/wlk.png",
    dim = {w = 150, h = 168},
    frate = 3,
    nframes = 12,
    anim = "loop"},
  hit = {
    res = "res/chars/bheart/hit.png",
    dim = {w = 200, h = 167},
    frate = 4,
    nframes = 3,
    anim = "play"},
  hitair = {
    res = "res/chars/bheart/hitair.png",
    dim = {w = 222, h = 141},
    frate = 0,
    nframes = 2,
    anim = Game.Anim.Air2(this)},
  hitflr = {
    res = "res/chars/bheart/hitflr.png",
    dim = {w = 254, h = 69},
    pad = {x = 0.5, y = -20},
    frate = 30,
    nframes = 1,
    anim = "play"},
  die = {
    res = "res/chars/bheart/hitflr.png",
    rad = 0,
    dim = {w = 254, h = 69},
    pad = {x = 0.5, y = -20}},
  atk = {
    res = "res/chars/bheart/atk1.png",
    dim = {w = 288, h = 174},
    frate = 4,
    nframes = 4,
    anim = "play"},
  atkalt = {
    res = "res/chars/bheart/atk2.png",
    dim = {w = 308, h = 174},
    frate = 3,
    nframes = 5,
    anim = "play"},
  atkflr = {
    res = "res/chars/bheart/atk3.png",
    dim = {w = 252, h = 178},
    frate = 5,
    nframes = 5,
    anim = "play"},
}

actor.rules = {
  std = {
    this.check,
--    this.think,
    atkalt = this.isKey{"a[rl]>"},
    wlk = this.isKey{"[rlud]+>"},
    atk = this.isKey{"a>"},
  },
  wlk = {
--    this.think,
    wlk = this.move({"[rlud]+>"},{spd = {x = 90, z = 90}}),
    std = this.isNoKey,
  },
  atk = {
    this.isFrame(2, this.attack{dmg = 20}),
    std = this.isEnded,
  },
  hit = {
    hitair = this.noFloor,
    std = this.isEnded,
  },
  hitair = {
    hitflr = this.isFloor,
  },
  hitflr = {
    std = this.isEnded,
    die = this.isDied,
  },
  atkalt = {
    this.isFrame(3, this.attack{dmg = 15}),
    std = this.isEnded,
  },
}

actor.info.state = {
  wlk = {
    spd = {x = 90, z = 90},
    rng = {min = 144},
    ep = 1,
  },
      
  atk = {
    evade = true,
    ep = 160,
  },
      
  atkalt = {
    ep = 160,
  },
  
  hitflr = {evade = true},
  die = {evade = true},
}

return actor