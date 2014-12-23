--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

TextDraw = Class {
  graphics = Dependency("graphics"),
  
  draw = function(this, data, scene)
    local pos = data:pos()
    local val = data:val()
    
    this.graphics.print(val, pos.x, pos.y)
  end,
}
