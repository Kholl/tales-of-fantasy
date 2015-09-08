--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/camera/Camera")

require("lib/game/ui/dialog/Dialog")
require("lib/game/ui/frame/Frame")
require("lib/game/ui/image/Image")
require("lib/game/ui/text/Text")

return {
  fps = 30,
  ratio = {x = 1, y = 1, z = 1/2},
  drag = {x = -300, y = 480, z = -300},
  pos = {x = 0.5, y = 0.5},
  grav = "y",
  lim = {
    x = {min = 0, max = 4800},
    y = {max = 0},
    z = {min = 0, max = 480},
  },
  off = {x = 0, y = 0},
  
  scrolls = {
    Scroll.new{
      res = "game/backs/palace.bg1.png",
      scr = {x = "clamp", y = "clamp"},
      pos = {x = 0, y = 0},
      dim = {w = 256, h = 256},
    },
    Scroll.new{
      res = "game/backs/palace.bg2.png",
      scr = {x = "repeat", y = "clamp"},
      pos = {x = 256, y = 0},
      dim = {w = nil, h = 256},
    },
  },
  
  actors = {
    player = Actor.new("game/chars/Sarah.lua", {
      player = 1,
      pos = {x = 100, y = 0, z = 400},
      dir = {x = 1, y = 1, z = 0},
    }),

    enemy = Actor.new("game/chars/Demon.lua", {
      pos = {x = 600, y = 0, z = 400},
      dir = {x = -1, y = 1, z = 0},
      flip = {h = -1, v = 1},
    }),
  },
  
  list = {
    camera = Camera.new{pos = {x = 100, z = 400}},
    
    script = SceneRules.new{
      start = {
        with("camera", focus("player")),
        with("player", { run("keyb"), target("enemy"), extra("faction").set("player") }),      
        with("enemy",  { run("AI"), target("player"), extra("faction").set("enemy") }),
        act("run"),
      },
    }
  }
}