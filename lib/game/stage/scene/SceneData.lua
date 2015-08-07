  --[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")

SceneData = Class {
  super = GraphicData,
  
  lim = Property("_lim"), -- Limits
  off = Property("_off", {use = XY}), -- Offset
  time = Property("_time"), -- Local time
  ratio = Property("_ratio", {use = XYZ}), -- Coordinate ratio
  frame = Property("_frame", {use = math.floor, trigger = "stepFrame"}), -- Frame
  state = Property("_state"), -- State
  
  create = function(this, init)
    GraphicData.create(this, init)
    
    this:off(init and init.off or {x = 0, y = 0})
    this:lim(init and init.lim or {})
    this:time(init and init.time or 0)
    this:ratio(init and init.ratio or {x = 1, y = 1, z = 1})
    this:frame(init and init.frame or 0)
    this:state(init and init.state or "start")
  end,
  
  update = function(this, delta, scene, game)
    this._stepframe = false
    this._time = delta + this._time
    this:frame(this._time * game.fps)
  end,
  
  stepFrame = function(this) this._stepframe = true end,
  onFrame = function(this) return this._stepframe end,
}