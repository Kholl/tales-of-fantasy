--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")

ImageData = Class {
  super = GraphicData,
  
  image = Property("_image"), -- Image
  
  create = function(this, init)
    GraphicData.create(this, init)
    this:image(init and init.res)
  end,
}