--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

local player
local triggered = false

return {
  fps = 30,
  
  lim = {
    x = {min = 160, max = 640},
    y = {max = 0},
    z = {min = 225, max = 235},
  },
  
  phys = {
    drag = {x = -240, y = 480, z = -240},
    grav = "y"
  },
  
  rules = {
    update = {
      chk = function() return not (player == nil) end,
      cmd = function() 
        scene:off{
          x =  160 - player:pos().x,
          y = -100 - player:pos().y,
        }
      end},
    
    start = {
      chk = function() return scene.frame == 0 end,
      cmd = function()
        scene.scrolls:addNew{
          res = "res/backs/mountain.bg.png",
          scr = {x = "repeat", y = "clamp"},
          pos = {x = 0, y = -50},
          mul = {x = 0.5, y = 0.5},
        }
        
        scene.scrolls:addNew{
          res = "res/backs/mountain.fg.png",
          scr = {x = "repeat", y = "clamp"},
          pos = {x = 0, y = 217},
        }
        
        player = scene.actors:addNew("res/chars/Elf.lua")
        player:pos{x = 160, y = 0, z = 225}
        scene:addKeyb(player, {keys = {r = "right", l = "left", u = "up", d = "down", a = "a", b = "z"}})
        
        scene:addRules(player, "res/rules/Keyb.lua")
        scene:addRules(player, "res/rules/Actor.lua")
      
        enemy = scene.actors:addNew("res/chars/Orc.lua")
        enemy:pos{x = 400, y = 230, z = 225}
        scene:addRules(enemy, "res/rules/Auto.lua")
        scene:addRules(enemy, "res/rules/Actor.lua")
        
        enemy = scene.actors:addNew("res/chars/Elf.lua")
        enemy:pos{x = 600, y = 230, z = 225}
        scene:addRules(enemy, "res/rules/Auto.lua")
        scene:addRules(enemy, "res/rules/Actor.lua")
      end},
  }
}