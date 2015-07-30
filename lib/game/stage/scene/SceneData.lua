  --[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")

SceneData = Class {
  super = GraphicData,
  
  lim = Property("_lim"), -- Limits
  off = Property("_off", {use = XY}), -- Offset
  time = Property("_time"),   -- Local time
  ratio = Property("_ratio", {use = XYZ}), -- Coordinate ratio
  state = Property("_state"), -- State
  
  _step = nil,
  _frame = nil,
  
  create = function(this, init)
    GraphicData.create(this, init)
    
    this:off(init and init.off or {x = 0, y = 0})
    this:lim(init and init.lim or {})
    this:time(init and init.time or 0)
    this:ratio(init and init.ratio or {x = 1, y = 1, z = 1})
    this:state(init and init.state or "start")
    
    this._step, this._frame = false, 0
  end,
  
  update = function(this, delta, scene, game)    
    this._time = delta + this._time
    
    local lastframe = this._frame
    this._frame = math.floor(this._time * game.fps)
    this._step = this._frame > lastframe
  end,
  
  isStep = function(this) return this._step end,
}