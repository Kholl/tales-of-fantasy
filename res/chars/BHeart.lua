--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

actor = {}
actor.action = false
actor.state = "std"
actor.box = {w = 24, h = 68}

actor.info = {
  dir = {x = 0, z = 0},
  state = {
  },
}

actor.states = {
  std = {
    res = "res/chars/BHeart/std.png",
    dim = {w = 127, h = 177}, pad = {x = 0.5, y = 1},
    frate = 4, nframes = 9, anim = "loop"},
}

return actor