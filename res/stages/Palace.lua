--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

local player

return {
  fps = 30,
  
  lim = {
    x = {min = 180, max = 6400},
    y = {max = 0},
    z = {min = 110, max = 256},
  },
  
  phys = {
    drag = {x = -240, y = 480, z = -240},
    grav = "y"
  },
  
  rules = {
    update = {
      chk = function() return not (player == nil) end,
      cmd = function() 
        scene.actors:sort(function(a, b) return a:pos().z < b:pos().z end)
        scene:off{
          x = 160 - player:pos().x,
          y = Math.Lim(160 - player:pos().z, {min = -56, max = 0})
        }
      end},
    
    start = {
      chk = function() return scene.frame == 0 end,
      cmd = function()
        scene.scrolls:addNew{
          res = "res/backs/palace.bg1.png",
          scr = {x = "clamp", y = "clamp"},
          pos = {x = 0, y = 0},
        }
        
        scene.scrolls:addNew{
          res = "res/backs/palace.bg2.png",
          scr = {x = "repeat", y = "clamp"},
          pos = {x = 256, y = 0},
        }
        
        player = scene.actors:addNew("res/chars/Elf.lua")
        player:pos{x = 160, y = 0, z = 225}
        scene:addKeyb(player, {keys = {r = "right", l = "left", u = "up", d = "down", a = "a", b = "z"}})
        
        scene:addRules(player, "res/rules/Keyb.lua")
        scene:addRules(player, "res/rules/Actor.lua")

        enemy = scene.actors:addNew("res/chars/BHeart.lua")
        enemy:pos{x = 600, y = 230, z = 225}
--        scene:addRules(enemy, "res/rules/Auto.lua")
--        scene:addRules(enemy, "res/rules/Actor.lua")
      end},
  }
}