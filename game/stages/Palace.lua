--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  fps = 30,
  ratio = {x = 1, y = 1, z = 1/2},
  drag = {x = -240, y = 480, z = -240},
  grav = "y",
  
  script = {
    start = function(scene)
      scene:lim{
        x = {min = 0, max = 480},
        y = {max = 0},
        z = {min = 360, max = 480},
      }
      
      scene:addScroll{
        res = "game/backs/palace.bg3.png",
        scr = {x = "clamp", y = "clamp"},
        pos = {x = 0, y = 0},
      }
      
      scene:off{x = -80, y = 0}
      
      local player = scene:addActor("game/chars/Sarah.lua")
--      player:auto(KeybDlg.new("conf/keyb1.lua"))
      player:pos{x = 200, y = 0, z = 400}

      local telarin = scene:addActor("game/chars/TelArin.lua")
      telarin:pos{x = 680, y = 0, z = 400}
      telarin:dir{x = -1, y = 1, z = 0}
      telarin:auto(ScriptDlg.new{script = {
        start = function()
          ActorScript.act("wlk")(telarin, scene)
          return "move"
        end,
        move = function()
          if telarin:pos().x <= 280 then
            ActorScript.act("std")(telarin, scene)
            return "stop"
          end
        end,
        stop = function()
        end,
      }})

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
      return "update"
    end,
  
    update = function(scene)
--[[
      List.sort(scene.actors, function(actor) return actor:pos().z end)
      
      local off = {
        x = 160 - (camera:pos().x * scene:ratio().x),
        y = 100 - (camera:pos().z * scene:ratio().z) - (camera:pos().y * scene:ratio().y)}
      off.y = Math.Lim(off.y, {min = -56, max = 0})
      scene:off(off)
]]--      
      return "update"
    end,
  }
}