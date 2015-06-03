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
}