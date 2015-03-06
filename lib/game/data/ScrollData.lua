--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScrollData = Class {
  pos = Property("_pos"), -- Position
  mul = Property("_mul"), -- Multiplier (parallax)
  scr = Property("_scr"), -- Scroll    

  create = function(this, init)
    this:pos(XY(init and init.pos or {0, 0}))
    this:mul(XY(init and init.mul or {1, 1}))
    this:scr(init and init.scr or {x = "repeat", y = "repeat"})
  end,
}