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
    Animator.new{prop = "dim", key = "h", v = {0.5, 1}, t = {23, 24}},
    
    camera = Camera.new{pos = {x = 100, z = 325}},
    
    script = SceneDlg.new{
      start = {function(scene, game)
        scene:get("camera"):focus("player")
        
        scene:actor("player"):state("wlk")
        scene:actor("telarin"):state("wlk")
        
        scene:state("run")
      end},
      
      run = {
        Script.at(2) / function(scene, game)
          scene:actor("player"):state("std")
          scene:actor("telarin"):state("std")        
        end,
          
        Script.at(3) / function(scene, game)
          scene:addActor("dqueen", "game/chars/DQueen.lua", {
            pos = {x = 4000, y = 0, z = 425},
            flip = {h = -1, v = 1},
            dir = {x = -1, y = 1, z = 0},
          })
        
          scene:get("camera"):focus("dqueen")
          scene:actor("dqueen"):state("spl2")
        end,
        
        Script.at(4) / function(scene, game) scene:actor("dqueen"):state("std") end,
        Script.at(5) / Script.dialog("Palace.2.dlg.1.lua"),
        Script.at(10) / Script.focus("telarin"),
        Script.at(15) / function(scene, game)
          scene:actor("telarin"):script{
            Script.at(16) / Script.act("spl"),
            Script.at(16.5) / Script.act("spl1"),
            Script.at(17) / Script.act("spl5"),
            Script.at(19) / Script.act("rdy") }
        end,
        
        Script.at(19.5) / function(scene, game)
          scene:get("camera"):unfocus()
          scene:actor("telarin"):state("jmp")
          scene:actor("telarin"):spd{x = 330, z = 0, y = -160}
        end,
        
        Script.at(21) / Script.all{
          Script.spawn("guard1", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 125, y = 0, z = 375},
            dir = {x = 1, y = 1, z = 0} }),
          
          Script.spawn("guard2", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 75, y = 0, z = 375},
            dir = {x = 1, y = 1, z = 0} }),
          
          Script.spawn("guard3", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 25, y = 0, z = 375},
            dir = {x = 1, y = 1, z = 0} }),

          Script.spawn("guard4", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 100, y = 0, z = 425},
            dir = {x = 1, y = 1, z = 0} }),
        
          Script.spawn("guard5", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 50, y = 0, z = 425},
            dir = {x = 1, y = 1, z = 0} }),
        
          Script.spawn("guard6", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 0, y = 0, z = 425},
            dir = {x = 1, y = 1, z = 0} }),
        },
        
        Script.at(24) / function(scene, game)
          Group(scene:getActors("guard?")):state("std")
          
          scene:get("camera"):focus("player")
          scene:actor("player"):run("keyb")
          
          scene:addActor("demon1", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 800, y = -100, z = 375},
            dir = {x = -1, y = 1, z = 0} })
          
          scene:addActor("demon2", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 750, y = -100, z = 400},
            dir = {x = -1, y = 1, z = 0} })
          
          scene:addActor("demon3", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 700, y = -100, z = 425},
            dir = {x = -1, y = 1, z = 0} })
          
          scene:addActor("demon4", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 800, y = -100, z = 375},
            dir = {x = -1, y = 1, z = 0} })
          
          scene:addActor("demon5", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 750, y = -100, z = 400},
            dir = {x = -1, y = 1, z = 0} })
          
          scene:addActor("demon6", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 700, y = -100, z = 425},
            dir = {x = -1, y = 1, z = 0} })
        
          for i = 1,6 do
            local demon = scene:actor("demon" .. i)
            local guard = scene:actor("guard" .. i)
            demon:run("AI")
            guard:run("AI")
            demon:target(guard)
            guard:target(demon)
          end
          
          
          scene:actor("telarin"):pos{x = 3800}          
          scene:state("battle1")
        end,
      },
    }
  }
}