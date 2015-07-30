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
  color = {r = 0, g = 0, b = 0},
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

    telarin = Actor.new("game/chars/TelArin.lua", {
      pos = {x = 75, y = 0, z = 450},
      dir = {x = 1, y = 1, z = 0}
    }),
  },
  
  list = {
    Animator.new{prop = "color", key = {"r", "g", "b"}, t = {0, 1}},
    Animator.new{prop = "dim", key = "h", v = {0.5, 1}, t = {1, 2}},
    
    camera = Camera.new{pos = {x = 100, z = 325}},
    
    script = SceneDlg.new{
      start = {function(scene, game)
        scene:get("camera"):focus("player")
        
        scene:actor("player"):get("keyb"):stop()
        scene:actor("player"):state("wlk")
        scene:actor("telarin"):get("AI"):stop()
        scene:actor("telarin"):state("wlk")
        
        scene:state("move")
      end},
      
      move = {SceneScript.at(2) / function(scene, game)
        scene:actor("player"):get("keyb"):play()
        scene:actor("player"):state("std")
        scene:actor("telarin"):state("std")        
        scene:state("stop")
      end},
      
      stop = {SceneScript.at(3) / function(scene, game)
        scene:addActor("dqueen", "game/chars/DQueen.lua", {
          pos = {x = 4000, y = 0, z = 425},
          flip = {h = -1, v = 1},
          dir = {x = -1, y = 1, z = 0},
        })
      
        scene:get("camera"):focus("dqueen")
        scene:actor("dqueen"):get("AI"):stop()
        scene:actor("dqueen"):state("spl2")
      
        scene:state("end")
      end},
    },
  },
}
--      }})

--[[      
      local spawn
  --    Game.Scene.spawn(scene, "TelArin"):pos{x = 275, y = 0, z = 425}
      
      spawn = scene:addActor("game/chars/TelArin.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 275, y = 0, z = 425}
      
      spawn = scene:addActor("game/chars/HElfBoss.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 300, y = 0, z = 350}
      
      spawn = scene:addActor("game/chars/HElfBoss.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 250, y = 0, z = 500}
      
      spawn = scene:addActor("game/chars/HElf.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 375, y = 0, z = 350}
      
      spawn = scene:addActor("game/chars/HElf.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 350, y = 0, z = 400}
      
      spawn = scene:addActor("game/chars/HElf.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 325, y = 0, z = 450}
      
      spawn = scene:addActor("game/chars/HElf.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 300, y = 0, z = 500}

      spawn = scene:addActor("game/chars/BHeart.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 750, y = 0, z = 500}

      spawn = scene:addActor("game/chars/DWarrior.lua")
      spawn:auto(EnemyDlg.new())
      spawn:pos{x = 750, y = 0, z = 350}
]]--
--      return "update"
--    end,
  
--    update = function(scene)
--[[
      List.sort(scene.actors, function(actor) return actor:pos().z end)
      
      local off = {
        x = 160 - (camera:pos().x * scene:ratio().x),
        y = 100 - (camera:pos().z * scene:ratio().z) - (camera:pos().y * scene:ratio().y)}
      off.y = Math.Lim(off.y, {min = -56, max = 0})
      scene:off(off)
]]--      
--      return "update"
--    end,