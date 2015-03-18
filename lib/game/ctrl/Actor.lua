--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/State")
require("lib/game/ctrl/dlgs/ActorDlg")
require("lib/game/ctrl/dlgs/KeybDlg")
require("lib/game/data/ActorData")

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
  
  update = function(this, scene)
    State.update(this, scene)    
    if this:isKeyb() then this:keyb():update(this, scene) end
    this.actor:update(this, scene)
  end,
  
  dim = function(this) return this:curr():dim() end,
  box = function(this) return this:curr():box() end,
  rad = function(this) return this:curr():rad() end,
    
  dir = function(this, val) return this.data:dir(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  mass = function(this, val) return this.data:mass(val) end,
  keyb = function(this, val) return this.data:keyb(val) end,
  auto = function(this, val) return this.data:auto(val) end,
  target = function(this, val) return this.data:target(val) end,
    
  distrel = function(this, actor)
    actor = actor or this:target()
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
    actor = actor or this:target()
    local a, b = this:pos(), actor:pos()
    local angle = math.atan2(a.z - b.z, a.x - b.x)
    return {x = math.cos(angle), z = math.sin(angle)}
  end,
  
  face = function(this, actor)
    actor = actor or this:target()
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
  
  -- Actions  
  act = function(action) return F(function(actor, scene)
    State.start(actor, action)
  end)
  end,
  
  find = F(function(actor, scene)
    local auto = actor:auto()
    local actors = scene:getActors()
    actors = List.filter(actors, auto.filter(actor, scene))
    actors = List.sort(actors, auto.eval(actor, scene))
    actor:target(actors[1])
  end),
  
  move = function(info) return function(actor, scene)
    local spd = actor:spd()
    if info.spd.y then spd.y = info.spd.y end
        
    local kx, kz = (actor:keyb() or actor:auto()):direction(actor)
    if not (kx == 0) then spd.x, actor:dir().x = kx * (info.spd.x or 0), kx end
    if not (kz == 0) then spd.z, actor:dir().z = kz * (info.spd.z or 0), kz end
    
    actor:spd(spd)
    
    return true
  end
  end,
  
  hitAll = function(hit) return function(actor, scene)
    local hits = scene:getHits(actor)
    List.each(hits, function(other) actor:hit(other, hit) end)
  end
  end,
  
  -- Triggers
  isHit = function(state) return F(function(actor, scene, target)
    target = target or actor:target()
    state = state or actor:state() 
    local f = Math.Sign(actor:dir().x)
    local d = actor:dist(target)
    if (f ==  1 and actor:pos().x < target:pos().x) or
       (f == -1 and actor:pos().x > target:pos().x) then
      
      local x, z = (actor.states[state]:dim().w * 0.5) + target:rad(), target:rad()
      return d.x < x and d.z < z
    end
    
    return false
  end)
  end,  
  
  isKey = function(key) return F(function(actor, scene)
    return actor:isKeyb() and actor:keyb():isKey(key)
  end)
  end,
  
  isFrame = function(nframe) return F(function(actor, scene)
    return actor:curr():isStep() and actor:curr():frame() == nframe
  end)
  end,
      
  isDied = F(function(this) return this.info.hp == 0 end),
  isFall = F(function(this) return this:spd().y > 0 end),
  isKeyb = F(function(this) return not (this:keyb() == false) end),
  isAuto = F(function(this) return not (this:auto() == false) end),
  isEnded = F(function(this) return this:curr():isEnded() end),
  isTarget = F(function(this) return not (this:auto() == false or this:target() == false) end),  
}
