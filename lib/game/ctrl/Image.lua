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
    this.data:sca(this.drawable:size())
  end,
  
  draw = function(this, offset)
    this.drawable:draw(this.data, offset)
  end,
  
  update = Nil,
  
  sca = function(this, val) return this.data:sca(val) end,
  pos = function(this, val) return this.data:pos(val) end,
  rot = function(this, val) return this.data:rot(val) end,
  dim = function(this, val) return this.data:dim(val) end,
}
