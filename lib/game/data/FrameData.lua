--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

FrameData = Class {
  pos = Property("_pos"), -- Position
  dim = Property("_dim"), -- Dimension
  border = Property("_border"), -- Border

  create = function(this, init)
    this:dim(init and init.dim)
    this:pos(init and init.pos or {x = 0, y = 0})
    this:border(init and init.border or 0)
  end,
}