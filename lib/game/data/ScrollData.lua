--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScrollData = Class {
  pos = Property("_pos"), -- Position
  mul = Property("_mul"), -- Multiplier (parallax)
  scr = Property("_scr"), -- Scroll    

  create = function(this, init)
    this:pos(init and init.pos or {x = 0, y = 0})
    this:mul(init and init.mul or {x = 1, y = 1})
    this:scr(init and init.scr or {x = "repeat", y = "repeat"})
  end,
}