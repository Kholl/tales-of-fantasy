--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ImageData = Class {
  sca = Property("_sca"), -- Scale
  pos = Property("_pos"), -- Position

  create = function(this, init)
    this:sca(init and init.sca or {x = 1, y = 1})
    this.pos(init and init.pos or {x = 0, y = 0, z = 0})
  end,
}