--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/GraphicData")

FrameData = Class {
  super = GraphicData,
  
  bdSize = Property("_bdSize"), -- Border size
  
  create = function(this, init)
    GraphicData.create(this, init)
    this:bdSize(init and init.bdSize or {w = 0, h = 0})
  end,
  
  area = function(this, parent)
    local area = GraphicData.area(this, parent)
    local bdSize = this:bdSize()
    area.x = area.x + bdSize.w
    area.y = area.y + bdSize.h
    area.w = area.w - 2*bdSize.w
    area.h = area.h - 2*bdSize.h
    
    return area
  end,
}