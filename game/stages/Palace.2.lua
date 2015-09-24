--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/camera/Camera")

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
    fadeIn =  Animator.new{prop = "color", key = {"r", "g", "b"}},
    cineOut = Animator.new{prop = "dim", key = "h", val = {0.5, 1}},
    
    camera = Camera.new{pos = {x = 100, z = 325}},
    
    script = SceneRules.new{
      {
        at(0) / {
          with("camera", focus("player")),
          with("player", act("wlk")),
          with("telarin", act("wlk")),
          run("fadeIn") },
      
        at(2) / {
          with("player", act("std")),
          with("telarin", act("std")) },
          
        at(3) / {
          spawn("dqueen", "game/chars/DQueen.lua", {
            state = "spl2",
            pos = {x = 4000, y = 0, z = 425},
            dir = {x = -1, y = 1, z = 0},
            flip = {h = -1, v = 1},
          }),
        
          with("camera", focus("dqueen")),
          with("dqueen", script{
            at(4) / act("std") }),
        },
        
        at( 5) / dialog("Palace.2.dlg.1.lua"),
        at(10) / with("camera", focus("telarin")),
        at(15) / with("telarin", script{
          at(16.0) / act("spl"),
          at(16.5) / act("spl1"),
          at(17.0) / act("spl5"),
          at(19.0) / act("rdy") }),
        
        at(19.5) / {
          with("camera", unfocus),
          with("telarin", act("jmp")),
          with("telarin", move{x = 330, z = 0, y = -160})
        },
        
        at(20) / run("cineOut"),
        
        at(21) / {
          spawn("guard1", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 125, y = 0, z = 375},
            dir = {x = 1, y = 1, z = 0} }),
          
          spawn("guard2", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 75, y = 0, z = 375},
            dir = {x = 1, y = 1, z = 0} }),
          
          spawn("guard3", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 25, y = 0, z = 375},
            dir = {x = 1, y = 1, z = 0} }),

          spawn("guard4", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 100, y = 0, z = 425},
            dir = {x = 1, y = 1, z = 0} }),
        
          spawn("guard5", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 50, y = 0, z = 425},
            dir = {x = 1, y = 1, z = 0} }),
        
          spawn("guard6", "game/chars/HElf.lua", {
            state = "wlk",
            pos = {x = 0, y = 0, z = 425},
            dir = {x = 1, y = 1, z = 0} }),
        },
        
        at(24) / {
          all("guard?", act("std")),
          
          with("camera", focus("player")),
          with("player", run("keyb")),
          with("telarin", set("pos"){x = 3800}),

          spawn("demon1", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 800, y = -100, z = 375},
            dir = {x = -1, y = 1, z = 0} }),
          
          spawn("demon2", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 750, y = -100, z = 400},
            dir = {x = -1, y = 1, z = 0} }),
          
          spawn("demon3", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 700, y = -100, z = 425},
            dir = {x = -1, y = 1, z = 0} }),
          
          spawn("demon4", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 800, y = -100, z = 375},
            dir = {x = -1, y = 1, z = 0} }),
          
          spawn("demon5", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 750, y = -100, z = 400},
            dir = {x = -1, y = 1, z = 0} }),
          
          spawn("demon6", "game/chars/Demon.lua", {
            state = "fly",
            flip = {h = -1, v = 1},
            pos = {x = 700, y = -100, z = 425},
            dir = {x = -1, y = 1, z = 0} }),
        
          all("guard?", run("AI")),
          all("demon?", run("AI")),
          act("battle"),
          
          function(actor, scene, game)
            for i = 1,6 do
              local demon = scene:actor("demon" .. i)
              local guard = scene:actor("guard" .. i)
              demon:target(guard)
              guard:target(demon)
            end
          end,          
        },
      }
    }
  }
}