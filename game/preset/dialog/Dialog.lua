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
    rollout = Animator.new("lib/preset/animator/RollH.lua", {v = {24, 160}, t = { 0, 1}}),
    rollin =  Animator.new("lib/preset/animator/RollH.lua", {v = {160, 24}, t = {20,21}}),
    image = Image.new{
      bdColor = {r = 0.3, g = 0.8, b = 0.3},
      bgColor = {r = 0, g = 0, b = 0},
      list = {
        fadein =  Animator.new("lib/preset/animator/Fade.lua", {v = {0, 1}, t = { 1,  2}}),
        fadeout = Animator.new("lib/preset/animator/Fade.lua", {v = {1, 0}, t = { 9, 10}}),
      },
    },
    text = Text.new{
      res = "game/ui/medieval.png",
      dim = {w = 0.6, h = 13 * 21},
      color = {r = 0.3, g = 0.8, b = 0.3},
      list = {
        fadein =  Animator.new("lib/preset/animator/Fade.lua",   {v = {0, 1}, t = { 1,  2}}),
        scroll =  Animator.new("lib/preset/animator/Scroll.lua", {v = {0, 1}, t = { 3,  9}}),
        fadeout = Animator.new("lib/preset/animator/Fade.lua",   {v = {1, 0}, t = { 9, 10}}),
      },
    },
  }
}