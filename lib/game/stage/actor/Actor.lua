--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/actor/ActorDlg")
require("lib/game/stage/actor/ActorScript")
require("lib/game/stage/actor/ActorData")
require("lib/game/stage/state/State")
require("lib/game/dlgs/KeybDlg")

Actor = Class {
  super = State,
  
  actor = nil,
  data = nil,
  info = nil,
  
  create = function(this, init)
    State.create(this, init)
    
    this.data = ActorData.new(init)
    this.actor = ActorDlg.new(init)
    this.info = init and init.info or {}
  end,
  
  draw = function(this, scene)
    State.draw(this, this.data, scene)
  end,
  
  step = function(this, scene, game)
    State.step(this, scene, game)    
--    if this:keyb() then this:keyb():step(this, scene, game) end
    if this:auto() then this:auto():step(this, scene, game) end
    this.actor:step(this, scene, game)
  end,
  
  update = function(this, delta, scene, game)
    State.update(this, delta, scene, game)    
--    if this:keyb() then this:keyb():update(this, scene, game) end
    if this:auto() then this:auto():update(this, scene, game) end
    this.actor:update(delta, this, scene, game)
  end,
  
  dim = function(this) return this:curr():dim() end,
  box = function(this) return this:curr():box() end,
  rad = function(this) return this:curr():rad() end,
    
  dir = function(this, val) return this.data:dir(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  mass = function(this, val) return this.data:mass(val) end,
  auto = function(this, val) return this.data:auto(val) end,
  target = function(this, val) return this.data:target(val) end,
    
  distrel = function(this, actor)
    actor = actor or this:target() or this
    local a, b = this:pos(), actor:pos()
    return {x = a.x - b.x, z = a.z - b.z}
  end,
  
  dist = function(this, actor)
    local d = this:distrel(actor)
    return {x = math.abs(d.x), z = math.abs(d.z)}
  end,
  
  eucl = function(this, actor)
    local d = this:dist(actor)
    return math.sqrt(d.x * d.x + d.z * d.z)
  end,
  
  angle = function(this, actor)
    actor = actor or this:target() or this
    local a, b = this:pos(), actor:pos()
    local angle = math.atan2(a.z - b.z, a.x - b.x)
    return {x = math.cos(angle), z = math.sin(angle)}
  end,
  
  face = function(this, actor)
    actor = actor or this:target() or this
    this:dir().x = Math.Sign(actor:pos().x - this:pos().x)
    return this
  end,
    
  hit = function(this, actor, hit)
    actor:face(this)
    actor:target(this)
    actor:start(action or "hit")
      
    local dist = this:dist(actor)
    local dirx = Math.Sign(actor:pos().x - this:pos().x)
      
    local force = hit.force or {}
    if force.x then actor:spd().x = dirx * hit.force.x end
    if force.y then actor:spd().y = hit.force.y end
    if force.z then actor:spd().z = hit.force.z end
  end,
}
