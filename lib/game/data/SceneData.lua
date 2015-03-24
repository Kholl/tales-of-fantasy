  --[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

SceneData = Class {
  fps = Property("_fps"),
  off = Property("_off"),
  lim = Property("_lim"),
  ratio = Property("_ratio"),
  delta = Property("_delta"),
  time = Property("_time"),
  frame = Property("_frame"),
  
  create = function(this, init)
    this:off(init and init.off or {x = 0, y = 0})
    this:lim(init and init.lim or {})
    this:fps(init and init.fps or 24)    
    this:ratio(init and init.ratio or {x = 1, y = 1, z = 1})
    this:delta(0)
    this:time(0)
    this:frame(0)
  end
}