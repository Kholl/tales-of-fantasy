--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/ImageData")

ActorData = Class {
  super = ImageData,
  
  spd = Property("_spd"), -- Speed
  mass = Property("_mass"), -- Mass
  floor = Property("_floor"), -- On floor
  target = Property("_target"), -- Target
  action = Property("_action"), -- Action

  create = function(this, init)
    ImageData.create(this, init)
    this:spd(init and init.spd or {x = 0, y = 0, z = 0})
    this:mass(init and init.mass or 1)
    this:floor(init and init.floor or true)
    this:target(init and init.target or false)
    this:action(init and init.action or false)
  end,
}