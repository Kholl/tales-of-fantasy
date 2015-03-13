--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ImageData = Class {
  pos = Property("_pos"), -- Position
  dim = Property("_dim"), -- Dimension
  col = Property("_col"), -- Color

  create = function(this, init)
    this:pos(init and init.pos or {x = 0, y = 0})
    this:dim(init and init.dim or {w = 0, h = 0})
    this:col(init and init.col or {r = 255, g = 255, b = 255})
  end,
}