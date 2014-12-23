--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/TextData")
require("lib/game/draw/TextDraw")

Text = Class {
  drawable = nil,
  data = nil,
  
  create = function(this, init)
    this.drawable = TextDraw.new(init)
    this.data = TextData.new(init)
    this.update = init.update or Nil
  end,
  
  draw = function(this)
    this.drawable:draw(this.data)
  end,
  
  pos = function(this, val) return this.data:pos(val) end,
  val = function(this, val) return this.data:val(val) end,
}
