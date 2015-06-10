--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/scroll/ScrollData")
require("lib/game/stage/scroll/ScrollDraw")

Scroll = Class {
  drawable = nil,
  data = nil,
  
  create = function(this, init)
    this.drawable = ScrollDraw.new(init)
    this.data = ScrollData.new(init)
  end,
  
  draw = function(this, scene, area)
    this.drawable:draw(this.data, scene)
  end,
  
  step = Nil,
  update = Nil,
}
