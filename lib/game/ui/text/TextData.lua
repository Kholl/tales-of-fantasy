--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")

TextData = Class {
  super = GraphicData,
  
  txt = Property("_txt"), -- Text
  fit = Property("_fit"), -- Fit dimensions
  align = Property("_align"), -- Alignment
  
  create = function(this, init)
    GraphicData.create(this, init)
    this:txt(init and init.txt or "")
    this:fit(init and init.fit or {w = false, h = false})
    this:align(init and init.align or 'left')
  end,
}