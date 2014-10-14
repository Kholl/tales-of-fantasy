--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ImageDraw = Class {
  graphics = Dependency("graphics"),
  
  drawable = nil,
  
  create = function(this, init)
    local resource = init and init.res
    this.drawable = this.graphics.newImage(resource)
  end,
  
  draw = function(this, data, scene)
    local pos = data:pos()
    local dir = data:dir()
    local off = scene:off()
    
    this.graphics.draw(this.drawable,
      off.x + pos.x, off.y + pos.y + pos.z, 0, dir.x, dir.y)
  end,
}
