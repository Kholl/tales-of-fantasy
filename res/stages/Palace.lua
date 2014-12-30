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
    z = {min = 250, max = 500},
  },
  
  phys = {
    drag = {x = -240, y = 480, z = -240},
    grav = "y"
  },
  
  ratio = {x = 1, y = 1, z = 1/2},
  
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
          :addKeyb{r = "right", l = "left", u = "up", d = "down", a = "a", b = "z"}
          :addRules("res/rules/Keyb.lua")
          :addRules("res/rules/Actor.lua")
        player:pos{x = 160, y = 0, z = 375}
        
        scene.ifaces:add(scene.IFACE.Text.new{
          pos = {x = 50, y = 50},
          update = function(this, scene)
            this:val(player.info.hp)
          end,
        })
--[[        
        scene.actors:addNew("res/chars/DElfBoss.lua")
          :addRules("res/rules/Auto.lua")
          :addRules("res/rules/Actor.lua")
          :pos{x = 200, y = 0, z = 300}
        
        scene.actors:addNew("res/chars/TelArin.lua")
          :addRules("res/rules/Auto.lua")
          :addRules("res/rules/Actor.lua")
          :pos{x = 200, y = 0, z = 375}
        ]]--
        scene.actors:addNew("res/chars/DElf.lua")
          :addRules("res/rules/Auto.lua")
          :addRules("res/rules/Actor.lua")
          :pos{x = 200, y = 0, z = 450}
        --[[
        scene.actors:addNew("res/chars/DWarrior.lua")
          :addRules("res/rules/Auto.lua")
          :addRules("res/rules/Actor.lua")
          :pos{x = 800, y = 0, z = 300}
        
        scene.actors:addNew("res/chars/BHeart.lua")
          :addRules("res/rules/Auto.lua")
          :addRules("res/rules/Actor.lua")
          :pos{x = 800, y = 0, z = 450}]]--
     end},
  }
}