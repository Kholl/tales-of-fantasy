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
  
  phys = {
    drag = {x = -240, y = 480, z = -240},
    grav = "y"
  },
  
  ratio = {x = 1, y = 1, z = 1/2},
  
  rules = {
    update = {
      chk = function() return not (camera == nil) end,
      cmd = function() 
        scene.actors:sort(function(a, b) return a:pos().z < b:pos().z end)
        
        local off = {
          x = 160 - (camera:pos().x * scene:ratio().x),
          y = 100 - (camera:pos().z * scene:ratio().z) - (camera:pos().y * scene:ratio().y)}
        off.y = Math.Lim(off.y, {min = -56, max = 0})
        scene:off(off)
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
        
        local players = {
          scene.actors:addNew("res/chars/Sarah.lua"),
        }
        
        Each(players, function(i, player)
          player:addKeyb{r = "right", l = "left", u = "up", d = "down", a = "a", b = "z"}
            :addRules("res/rules/Keyb.lua")
            :addRules("res/rules/Actor.lua")
        end)
        
        players[1]:pos{x = 160, y = 0, z = 415}
        camera = players[1]
        
        local autos = {
          scene.actors:addNew("res/chars/HElfBoss.lua"),
          scene.actors:addNew("res/chars/HElfBoss.lua"),
          scene.actors:addNew("res/chars/HElf.lua"),
          scene.actors:addNew("res/chars/HElf.lua"),
          scene.actors:addNew("res/chars/HElf.lua"),
          scene.actors:addNew("res/chars/HElf.lua"),
          scene.actors:addNew("res/chars/TelArin.lua"),
          scene.actors:addNew("res/chars/DWarrior.lua"),
          scene.actors:addNew("res/chars/BHeart.lua"),
        }
        
        Each(autos, function(i, auto)
          auto:addRules("res/rules/Auto.lua")
            :addRules("res/rules/Actor.lua")
        end)
        
        autos[1]:pos{x = 300, y = 0, z = 350}
        autos[2]:pos{x = 250, y = 0, z = 500}
        autos[3]:pos{x = 375, y = 0, z = 350}
        autos[4]:pos{x = 350, y = 0, z = 400}
        autos[5]:pos{x = 325, y = 0, z = 450}
        autos[6]:pos{x = 300, y = 0, z = 500}     
        autos[7]:pos{x = 275, y = 0, z = 425}     
        autos[8]:pos{x = 800, y = 0, z = 350}     
        autos[9]:pos{x = 775, y = 0, z = 500}     
        
        Each({1,2,3,4,5,6,7}, function (i) autos[i].info.faction = players[1].info.faction end)
     end},
  }
}