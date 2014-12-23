--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

TextData = Class {
  pos = Property("_pos"), -- Position
  val = Property("_val"), -- Value

  create = function(this, init)
    this:pos(init and init.pos or {x = 0, y = 0})
    this:val(init and init.val or "")
  end,
}