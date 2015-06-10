--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")

TextData = Class {
  super = GraphicData,
  
  txt = Property("_txt"), -- Text
  txtalign = Property("_txtalign"), -- Text Alignment
  
  create = function(this, init)
    GraphicData.create(this, init)
    this:txt(init and init.txt or "")
    this:txtalign(init and init.txtalign or 'left')
  end,
}