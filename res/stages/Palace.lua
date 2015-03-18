--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

local camera

return {
  fps = 30,
  
  lim = {
    x = {min = 180, max = 6400},
    y = {max = 0},
    z = {min = 250, max = 500},
  },
  
  drag = {x = -240, y = 480, z = -240},
  grav = "y",
  
  ratio = {x = 1, y = 1, z = 1/2},
  
  commands = {
    start = function(scene)
      scene:addScroll{
        res = "res/backs/palace.bg1.png",
        scr = {x = "clamp", y = "clamp"},
        pos = {x = 0, y = 0},
      }
      
      scene:addScroll{
        res = "res/backs/palace.bg2.png",
        scr = {x = "repeat", y = "clamp"},
        pos = {x = 256, y = 0},
      }
      
      local player = scene:addActor("res/chars/Sarah.lua")
      player:keyb(KeybDlg.new{r = "right", l = "left", u = "up", d = "down", a = "a", b = "s"})
      player:pos{x = 200, y = 0, z = 425}
         
      camera = player
      
      
  --    Game.Scene.spawn(scene, "TelArin"):pos{x = 275, y = 0, z = 425}
  --    Game.Scene.spawn(scene, "HElfBoss"):pos{x = 300, y = 0, z = 350}
  --    Game.Scene.spawn(scene, "HElfBoss"):pos{x = 250, y = 0, z = 500}        
  --    Game.Scene.spawn(scene, "HElf"):pos{x = 375, y = 0, z = 350}
  --    Game.Scene.spawn(scene, "HElf"):pos{x = 350, y = 0, z = 400}
  --    Game.Scene.spawn(scene, "HElf"):pos{x = 325, y = 0, z = 450}
  --    Game.Scene.spawn(scene, "HElf"):pos{x = 300, y = 0, z = 500}        

      local bheart = scene:addActor("res/chars/BHeart.lua")
      bheart:auto(Game.Enemy)
      bheart:pos{x = 750, y = 0, z = 500}

  --    Game.Scene.spawn(scene, "DWarrior"):pos{x = 750, y = 0, z = 350}
  
      return "update"
    end,
  
    update = function(scene)
      List.sort(scene.actors, function(actor) return actor:pos().z end)
      
      local off = {
        x = 160 - (camera:pos().x * scene:ratio().x),
        y = 100 - (camera:pos().z * scene:ratio().z) - (camera:pos().y * scene:ratio().y)}
      off.y = Math.Lim(off.y, {min = -56, max = 0})
      scene:off(off)
      
      return "update"
    end,
  }
}