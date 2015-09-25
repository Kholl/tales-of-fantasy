--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/image/Image")

return Image.new{
  img = "game/ui/bar/bar.fg.png",
  bgImage = "game/ui/bar/bar.bg.png",
  
  pos = {x = 0, y = 0},
  dim = {w = 122, h = 35},
  
  list = {
    portrait = Image.new{
      img = "game/chars/Lucia/portrait-s.png",
      pos = {x = 8, y = 11},
      dim = {w = 30, h = 13}
    },
    
    hpbar = Image.new{
      img = "game/ui/bar/bar.png",
      pos = {x = 66, y = 13},
      dim = {w = 48, h = 4},
      view = {x = 66, w = 48, h = 4},
    }, 
    
    mpbar = Image.new{
      img = "game/ui/bar/bar.png",
      pos = {x = 66, y = 18},
      dim = {w = 48, h = 4},
      view = {x = 66, w = 48, h = 4},
    }, 
  }
}