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
      return "move"
    end,
    move = function(scene, game)
      if scene.actors.telarin:pos().x > 280 then return end
      
      ActorScript.act("std")(scene.actors.telarin, scene)
      
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
      return "talk"
    end,
    talk = function(scene, game)
      if game.ui:time() > 18 then return "leave" end
      scene.actors.telarin:pos().x = 280
    end,
    leave = function(scene, game)
      scene.actors.telarin:dir{x = 1, y = 1, z = 0}
      ActorScript.act("wlk")(scene.actors.player, scene)
      ActorScript.act("wlk")(scene.actors.telarin, scene)      
      return "finish"
    end,
    finish = function(scene, game)
      if (scene.actors.telarin:pos().x < 450) or
         (scene.actors.player:pos().x  < 450) then return end
      
      assert(false)
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