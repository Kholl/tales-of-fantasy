--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorData = Class {
  pos = Property("_pos"), -- Position
  dir = Property("_dir"), -- Direction
  sca = Property("_sca"), -- Scale
  spd = Property("_spd"), -- Speed
  dmg = Property("_dmg"), -- Damage
  mass = Property("_mass"), -- Mass
  target = Property("_target"), -- Target
  action = Property("_action"), -- Action
  player = Property("_player"), -- Player id

  create = function(this, init)
    this:pos(init and init.pos or {x = 0, y = 0, z = 0})
    this:spd(init and init.spd or {x = 0, y = 0, z = 0})
    this:dir(init and init.dir or {x = 0, y = 0, z = 0})
    this:sca(init and init.sca or {w = 1, h = 1})
    this:dmg(init and init.dmg or 0)
    this:mass(init and init.mass or 1)
    this:target(init and init.target or false)
    this:action(init and init.action or false)
    this:player(init and init.player or 0)
  end,
}