--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ImageData = Class {
  pos = Property("_pos"), -- Position
  dim = Property("_dim"), -- Dimension
  col = Property("_col"), -- Color

  create = function(this, init)
    this:pos(XY(init and init.pos or {0, 0}))
    this:dim(WH(init and init.dim or {0, 0}))
    this:col(RGB(init and init.col or {255, 255, 255}))
  end,
}