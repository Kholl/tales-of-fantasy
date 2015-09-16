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
  dim = {w = 1, h = 0.5},
  grav = "y",
  lim = {
    x = {min = 0, max = 480},
    y = {max = 0},
    z = {min = 0, max = 480},
  },
  off = {x = -80, y = 0},
  
  scrolls = {
    Scroll.new{
      res = "game/backs/palace.bg3.png",
      scr = {x = "clamp", y = "clamp"},
      pos = {x = 0, y = 0},
    },
  },
  
  actors = {
    player = Actor.new("game/chars/Sarah.lua", {
      pos = {x = 200, y = 0, z = 300},
    }),
    telarin = Actor.new("game/chars/TelArin.lua", {
      pos = {x = 480, y = 0, z = 300},
      dir = {x = -1, y = 1, z = 0},
      flip = {h = -1, v = 1},
    }),
  },
  
  list = {
    fadeIn  = Animator.new{prop = "off", key = "y", val = {60, 15}},
    fadeOut = Animator.new{prop = "color", key = {"r", "g", "b"}, val = {1, 0}, len = 2},

    script = SceneRules.new{
      { at( 0) / { with("telarin", act("wlk")), run("fadeIn") },
        at( 2) / { with("telarin", act("std")), dialog("Palace.1.dlg.1.lua") },
        at(19) / {
          with("player", { act("wlk"), prop("dir"){x = 1, y = 1, z = 0} }),          
          with("telarin", { act("wlk"), prop("dir"){x = 1, y = 1, z = 0} }),
          run("fadeOut") },
        at(21) / Script.loadScene("game/stages/Palace.2.lua"),
      },
    },
  }
}