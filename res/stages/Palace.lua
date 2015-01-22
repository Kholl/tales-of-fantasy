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
  
  iface = Game.Gui.Bar.new{
    res = "res/gui/lifebar.png",
    pos = {x = 50, y = 50},
    dim = {w = 100, h = 12},
    col = {r = 0, g = 224, b = 0},
    prop = {val = "hp", max = "hpmax"},
  },
  
  start = function(scene)
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
    
    local player = Game.Scene.player(scene, "Sarah")
      {r = "right", l = "left", u = "up", d = "down", a = "a", b = "z"}
        
    camera = player
    
    player:pos{x = 200, y = 0, z = 425}
    scene.iface:target(player)
    
    Game.Scene.spawn(scene, "TelArin"):pos{x = 275, y = 0, z = 425}
    Game.Scene.spawn(scene, "HElfBoss"):pos{x = 300, y = 0, z = 350}
    Game.Scene.spawn(scene, "HElfBoss"):pos{x = 250, y = 0, z = 500}        
    Game.Scene.spawn(scene, "HElf"):pos{x = 375, y = 0, z = 350}
    Game.Scene.spawn(scene, "HElf"):pos{x = 350, y = 0, z = 400}
    Game.Scene.spawn(scene, "HElf"):pos{x = 325, y = 0, z = 450}
    Game.Scene.spawn(scene, "HElf"):pos{x = 300, y = 0, z = 500}        
    Game.Scene.spawn(scene, "BHeart"):pos{x = 750, y = 0, z = 500}
    Game.Scene.spawn(scene, "DWarrior"):pos{x = 750, y = 0, z = 350}
  end,
  
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
  }
}