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
  drag = {x = -240, y = 480, z = -240},
  grav = "y",
  lim = {
    x = {min = 0, max = 480},
    y = {max = 0},
    z = {min = 360, max = 480},
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
      pos = {x = 200, y = 0, z = 400},
    }),
    telarin = Actor.new("game/chars/TelArin.lua", {
      pos = {x = 680, y = 0, z = 400},
      dir = {x = -1, y = 1, z = 0}
    }),
  },

  script = {
    start = function(scene, game)
        ActorScript.act("wlk")(scene.actors.telarin, scene)
        return "moving"
      end,
    moving = function(scene, game)
      if scene.actors.telarin:pos().x > 280 then return "moving" end
      
      ActorScript.act("std")(scene.actors.telarin, scene)
      
      game.ui:add(Dialog.new("game/preset/dialog/Dialog.lua", {
        seqtime = {[0] = 10, 21},
        seq = {
          [0] = {
            image = {
              img = "game/chars/Lucia/portrait-m.png",
              pos = {x = 20, y = 0.5},
              dim = {w = 40, h = 60},
              dir = {x =  1, y = 1},
            },
            text = {
              txt = "ABCDEF\nGHIJKL\nMNOPQR\nSTUVWX\nYZ\nabcdef\nghijkl\nmnopqr\nstuvwx\nyz\n12345\n67890\n ,;.:-+/%?!",
              pos = {x = 1, y = 0},
            },
          },
          [1] = {
            image = {
              img = "game/chars/TelArin/portrait-m.png",
              pal = "game/preset/imagefx/HElf.lua",
              pos = {x = -20, y = 0.5},
              dim = {w = 48, h = 48},
              dir = {x = -1, y = 1},
            },
            text = {
              txt = "BLABLA\nBLABLA\nBLABLA\nBLABLA\nBL\nblabla\nblabla\nblabla\nblabla\nbl\n12345\n67890\n ,;.:-+/%?!",
              pos = {x = 0, y = 0},
            },
          },
        },
      }))

--[[        script = {
          start = function(dialog, ui)
            dialog:anm("lib/preset/Animator/RollH.lua", {v = {24, 160}, t = {0, 1}})
            dialog:get("portrait"):anm("lib/preset/Animator/Fade.lua", {t = {1, 2}})
            dialog:get("text"):anm("lib/preset/Animator/Fade.lua", {t = {1, 2}})
            dialog:get("text"):anm("lib/preset/Animator/ScrollDown.lua", {t = {4, 10}})
            
            return "update"
          end,
          update = function(dialog, ui)
            if dialog:time() < 10 then return "update" end
            if not Dependency("keyboard").isDown(game.keyb[1].a) then return "update" end
            
            dialog:get("portrait"):anm("lib/preset/Animator/Fade.lua", {v = {1, 0}, t = {0, 1}})
            dialog:get("text"):anm("lib/preset/Animator/Fade.lua", {v = {1, 0}, t = {0, 1}})
            dialog:anm("lib/preset/Animator/RollH.lua", {v = {160, 24}, t = {1, 2}})
            
            dialog:get("portrait"):anm("lib/preset/Animator/Fade.lua", {t = {3, 4}})
            dialog:get("text"):anm("lib/preset/Animator/Fade.lua", {t = {3, 4}})
            dialog:anm("lib/preset/Animator/RollH.lua", {v = {24, 160}, t = {2, 3}})
            
            dialog:time(0)
            return "next"
          end,
          
          next = function(dialog)
            if dialog:time() < 2 then return "next" end
            
            dialog:get("portrait"):pos{x = -20, y = nil}
            dialog:get("text"):pos{x = -80, y = 0}:txt(POLLO)
            dialog:time(0)
            
            return "update"
          end,
        },]]--
      
      return "talking"
    end,
    talking = function(scene, game)
      scene.actors.telarin:pos().x = 280
    end,
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
  }
}