--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Text = Class {
  drawable = nil,
  data = nil,
  
  create = function(this, init)
    this.drawable = TextDraw.new(init)
    this.data = TextData.new(init)
  end,
  
  draw = function(this, group, game)
    this.drawable:draw(this.data, group, game)
  end,
  
  step = Nil,
  update = Nil,
}