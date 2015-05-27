--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/GraphicData")

FrameData = Class {
  super = GraphicData,
  
  border = Property("_border"), -- Border size
  
  create = function(this, init)
    GraphicData.create(this, init)
    this:border(init and init.border or 0)
  end,
}