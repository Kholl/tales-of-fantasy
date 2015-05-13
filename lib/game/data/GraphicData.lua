--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

GraphicData = Class {
  pos = Property("_pos"), -- Position
  
  create = function(this, init)
    this:pos(init.pos or {x = 0, y = 0})
  end,
}