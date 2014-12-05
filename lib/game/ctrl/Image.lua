--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/ImageData")
require("lib/game/draw/ImageDraw")

Image = Class {
  drawable = nil,
  data = nil,
  
  create = function(this, init)
    this.drawable = ImageDraw.new(init)
    this.data = ImageData.new(init)
    this.update = init.update or Nil
  end,
  
  draw = function(this, scene)
    this.drawable:draw(this.data, scene)
  end,
  
  pos = function(this, val) return this.data:pos(val) end,
  dir = function(this, val) return this.data:dir(val) end,
}
