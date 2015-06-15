--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorData = Class {
  pos = Property("_pos"), -- Position
  dir = Property("_dir"), -- Direction
  spd = Property("_spd"), -- Speed
  mass = Property("_mass"), -- Mass
  auto = Property("_auto"),  
  target = Property("_target"), -- Target
  action = Property("_action"), -- Action

  create = function(this, init)
    this:pos(init and init.pos or {x = 0, y = 0, z = 0})
    this:dir(init and init.dir or {x = 1, y = 1, z = 0})
    this:spd(init and init.spd or {x = 0, y = 0, z = 0})
    this:mass(init and init.mass or 1)
    this:auto(init and init.auto or false)
    this:target(init and init.target or false)
    this:action(init and init.action or false)
  end,
}