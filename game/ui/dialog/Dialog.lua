--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  res = "game/ui/dialog/dialog2.png",
  pos = {x = 0.5, y = 0.5},
  dim = {w = 254, h = 160},
  bgColor = {r = 0, g = 0, b = 0},
  bgAlpha = 0.75,
  bdSize = {w = 7, h = 12},
  
  list = {
    rollOut = Animator.new{func = "Decel", prop = "dim", key = "h", val = {24, 160}},
    rollIn =  Animator.new{func = "Decel", prop = "dim", key = "h", val = {160, 24}},
    
    text = Text.new{
      hide = true,
      res = "game/ui/medieval.png",
      dim = {w = 0.7, h = 1},
      fit = {w = false, h = true},
      color = {r = 0.3, g = 0.8, b = 0.3},
      list = {
        fadeIn =  Animator.new{prop = "alpha"},
        scroll =  Animator.new{prop = "pos", key = "y"},
        fadeOut = Animator.new{prop = "alpha", val = {1, 0}},
      },
    },
    
    image = Image.new{
      hide = true,
      bdColor = {r = 0.3, g = 0.8, b = 0.3},
      bgColor = {r = 0, g = 0, b = 0},
      list = {
        fadeIn =  Animator.new{prop = "alpha"},
        fadeOut = Animator.new{prop = "alpha", val = {1, 0}},
      },
    },
  },
}