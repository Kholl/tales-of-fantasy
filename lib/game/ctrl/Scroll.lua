--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/ScrollData")
require("lib/game/draw/ScrollDraw")

Scroll = Class {
  drawable = nil,
  data = nil,
  
  create = function(this, init)
    this.drawable = ScrollDraw.new(init)
    this.data = ScrollData.new(init)
  end,
  
  draw = function(this, scene, game)
    this.drawable:draw(this.data, scene, game)
  end,
  
  step = Nil,
  update = Nil,
}
