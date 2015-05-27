--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/GraphicData")

TextData = Class {
  super = GraphicData,
  
  txt = Property("_txt"), -- Text
  align = Property("_align"), -- Align
  
  create = function(this, init)
    GraphicData.create(this, init)
    this:txt(init and init.txt or "")
    this:align(init and init.align or 'left')
  end,
}