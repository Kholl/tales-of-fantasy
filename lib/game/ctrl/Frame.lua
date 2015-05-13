--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/draw/FrameDraw")
require("lib/game/data/FrameData")

Frame = Class {
  drawable = nil,
  data = nil,
  
  create = function(this, init)
    this.drawable = FrameDraw.new(init)
    this.data = FrameData.new(init)
  end,
  
  draw = function(this, group, game)
    this.drawable:draw(this.data, group, game)
  end,
  
  step = Nil,
  update = Nil,
  
  pos = function(this, val) return this.data:pos(val) end,
  dim = function(this, val) return this.data:dim(val) end,
  border = function(this, val) return this.data:border(val) end,
}