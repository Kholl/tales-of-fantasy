--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/ImageData")

ActorData = Class {
  super = ImageData,
  
  spd = Property("_spd"),
  box = Property("_box"),
  cmd = Property("_cmd"),
  floor = Property("_floor"),
  target = Property("_target"),

  create = function(this, init)
    ImageData.create(this, init)
    this:spd(init and init.spd or {x = 0, y = 0, z = 0})
    this:box(init and init.box or {w = 0, h = 0})
    this:cmd(init and init.cmd or "idle")
    this:floor(init and init.floor or true)
    this:target(init and init.target or false)
  end,
}