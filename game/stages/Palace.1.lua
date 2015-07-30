--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

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
      pos = {x = 680, y = 0, z = 300},
      dir = {x = -1, y = 1, z = 0},
      flip = {h = -1, v = 1},
    }),
  },
  
  list = {
    Animator.new{prop = "off", key = "y", v = {60, 15}},
    Animator.new{prop = "color", key = {"r", "g", "b"}, v = {1, 0}, t = {19, 21}},
  
    script = SceneDlg.new{
      start = {function(scene, game)
        scene:actor("player"):get("keyb"):stop()
        scene:actor("telarin"):get("AI"):stop()
        scene:actor("telarin"):state("wlk")
        scene:state("move")
      end},
      
      move = {SceneScript.at(2.25) / function(scene, game)
        game.ui:add(Dialog.new("game/preset/dialog/Dialog.lua", {
          seqtime = {5, 15},
          seq = {
            {
              image = {
                img = "game/chars/Lucia/portrait-m.png",
                pos = {x = 10, y = 0.5},
                dim = {w = 40, h = 60},
                dir = {x =  1, y = 1},
              },
              text = {
                txt = "What happens? Everguardian Telhari, report me.",
                pos = {x = 1, y = 0.5},
                fit = {w = false, h = false},
              },
            },
            {
              image = {
                img = "game/chars/TelArin/portrait-m.png",
                pal = "game/preset/imagefx/HElf.lua",
                pos = {x = -10, y = 0.5},
                dim = {w = 48, h = 48},
                dir = {x = -1, y = 1},
              },
              text = {
                txt = "Elfinn Princess, the Green Tower defenses are being attacked by an army of Orq mercenaries. We have to leave the tower through the Hidden Backdoor. I will escort you.",
                pos = {x = 0, y = 0},
                fit = {w = false, h = true},
              },
            },
          },
        }))
          
        scene:actor("telarin"):state("std")
        scene:state("talk")
      end},
      
      talk = {SceneScript.at(19) / function(scene, game)
        scene:actor("player"):state("wlk")
        scene:actor("player"):dir{x = 1, y = 1, z = 0}
        scene:actor("telarin"):state("wlk")
        scene:actor("telarin"):dir{x = 1, y = 1, z = 0}
        scene:state("leave")
      end},
      
      leave = {SceneScript.at(21) / function(scene, game)
        Script.loadScene(game, "game/stages/Palace.2.lua")
      end},
    },
  }
}