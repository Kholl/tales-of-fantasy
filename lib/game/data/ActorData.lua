--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/ImageData")

ActorData = Class {
  pos = Property("_pos"), -- Position
  dir = Property("_dir"), -- Direction
  spd = Property("_spd"), -- Speed
  mass = Property("_mass"), -- Mass
  floor = Property("_floor"), -- On floor
  target = Property("_target"), -- Target
  action = Property("_action"), -- Action

  create = function(this, init)
    this:pos(XYZ(init and init.pos or {0, 0, 0}))
    this:dir(XYZ(init and init.dir or {1, 1, 0}))
    this:spd(XYZ(init and init.spd or {0, 0, 0}))
    this:mass(init and init.mass or 1)
    this:floor(init and init.floor or true)
    this:target(init and init.target or false)
    this:action(init and init.action or false)
  end,
}