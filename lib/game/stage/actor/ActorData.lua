--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorData = Class {
  pos = Property("_pos", {use = XYZ}), -- Position
  dir = Property("_dir", {use = XYZ}), -- Direction
  spd = Property("_spd", {use = XYZ}), -- Speed
  rad = Property("_rad"), -- Radius
  flip = Property("_flip"), -- Flip
  mass = Property("_mass"), -- Mass
  time = Property("_time"), -- Time
  state = Property("_state"), -- State
  extra = Property("_extra"), -- Extras
  target = Property("_target"), -- Target
  action = Property("_action"), -- Action
  player = Property("_player"), -- Player id
  
  create = function(this, init)
    this:pos(init and init.pos or {x = 0, y = 0, z = 0})
    this:spd(init and init.spd or {x = 0, y = 0, z = 0})
    this:dir(init and init.dir or {x = 0, y = 0, z = 0})
    this:rad(init and init.rad or 0)
    this:flip(init and init.flip or {h = 1, v = 1})
    this:mass(init and init.mass or 1)
    this:time(init and init.time or 0)
    this:state(init and init.state or "std")
    this:extra(init and init.extra or {})
    this:target(init and init.target or false)
    this:action(init and init.action or false)
    this:player(init and init.player or 0)
  end,
  
  update = function(this, delta, actor, scene, game)
    this._time = delta + this._time
  end,
}