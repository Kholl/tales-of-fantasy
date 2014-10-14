--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ImageData = Class {
  pos = Property("_pos"), -- Position
  dir = Property("_dir"), -- Direction

  create = function(this, init)
    this:pos(init and init.pos or {x = 0, y = 0, z = 0})
    this:dir(init and init.dir or {x = 1, y = 1})
  end,
}