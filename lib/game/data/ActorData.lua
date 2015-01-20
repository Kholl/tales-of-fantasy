--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/ImageData")

ActorData = Class {
  super = ImageData,
  
  spd = Property("_spd"),
  box = Property("_box"),
  rad = Property("_rad"),
  mass = Property("_mass"),
  floor = Property("_floor"),
  target = Property("_target"),
  action = Property("_action"),

  create = function(this, init)
    ImageData.create(this, init)
    this:spd(init and init.spd or {x = 0, y = 0, z = 0})
    this:box(init and init.box or {w = 0, h = 0})
    this:rad(init and init.rad or 0)
    this:mass(init and init.mass or 1)
    this:floor(init and init.floor or true)
    this:target(init and init.target or false)
    this:action(init and init.action or false)
  end,
}