--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  res = "game/ui/dialog2.png",
  pos = {x = 0.5, y = 0.5},
  dim = {w = 254, h = 160},
  bgColor = {r = 0, g = 0, b = 0},
  bgAlpha = 0.75,
  bdSize = {w = 7, h = 12},
  list = {
    ["in"] =  Animator.new("lib/preset/animator/RollH.lua", {v = {24, 160}, t = {0, 1}}),
    ["out"] = Animator.new("lib/preset/animator/RollH.lua", {v = {160, 24}, d = 1, stop = true}),
    text = Text.new{
      res = "game/ui/medieval.png",
      dim = {w = 0.7, h = 1},
      fit = {w = false, h = true},
      color = {r = 0.3, g = 0.8, b = 0.3},
      list = {
        ["in"] =  Animator.new("lib/preset/animator/Fade.lua",   {v = {0, 1}, t = {0, 1},  nxt = "scr"}),
        ["scr"] = Animator.new("lib/preset/animator/Scroll.lua", {v = {0, 1}, stop = true}),
        ["out"] = Animator.new("lib/preset/animator/Fade.lua",   {v = {1, 0}, d = 1, stop = true}),
      },
    },
    image = Image.new{
      bdColor = {r = 0.3, g = 0.8, b = 0.3},
      bgColor = {r = 0, g = 0, b = 0},
      list = {
        ["in"] =  Animator.new("lib/preset/animator/Fade.lua", {v = {0, 1}, t = {0, 1}}),
        ["out"] = Animator.new("lib/preset/animator/Fade.lua", {v = {1, 0}, d = 1, stop = true}),
      },
    },
  }
}