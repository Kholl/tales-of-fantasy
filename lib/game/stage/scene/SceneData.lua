  --[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")

SceneData = Class {
  super = GraphicData,
  
  off = Property("_off"),     -- Offset
  lim = Property("_lim"),     -- Limits
  ratio = Property("_ratio"), -- Coordinate ratio
  time = Property("_time"),   -- Local time
  step = Property("_step"),   -- Frame changed
  frame = Property("_frame"), -- Frame
  
  create = function(this, init)
    GraphicData.create(this, init)
    
    this:off(init and init.off or {x = 0, y = 0})
    this:lim(init and init.lim or {})
    this:ratio(init and init.ratio or {x = 1, y = 1, z = 1})
    this:time(0)
    this:step(false)
    this:frame(0)
  end
}