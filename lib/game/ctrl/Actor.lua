--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/State")
require("lib/game/ctrl/dlgs/ActorDlg")
require("lib/game/data/ActorData")

Actor = Class {
  super = State,
  
  keyb = nil,
  auto = nil,
  actor = nil,

  data = nil,
  info = nil,
  
  create = function(this, init)
    State.create(this, init)
    
    this.data = ActorData.new(init)
    this.actor = ActorDlg.new(init)
    this.info = init and init.info or {}
    
    this.keyb = false
    this.auto = false
    
    -- External functions
    this.isHit = init.isHit or Actor.isHit
  end,
  
  draw = function(this, scene)
    State.draw(this, this.data, scene)
  end,
  
  update = function(this, scene)
    State.update(this, scene)
    
    if this.auto then this.auto:update(this, scene)
    elseif this.keyb then this.keyb:update(this, scene)
    end
  
    this.actor:update(this, scene)
  end,
  
  dim = function(this) return this:curr():dim() end,
  box = function(this) return this:curr():box() end,
  rad = function(this) return this:curr():rad() end,
    
  dir = function(this, val) return this.data:dir(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  mass = function(this, val) return this.data:mass(val) end,
  floor = function(this, val) return this.data:floor(val) end,
  target = function(this, val) return this.data:target(val) end,
    
  useKeyb = function(this, dlg) this.keyb = dlg; return this end,
  useAuto = function(this, dlg) this.auto = dlg; return this end,
  
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
  move = function(info) return function(this, scene)
    local spd = this:spd()
    if info.spd.y then spd.y = info.spd.y end
    if this.keyb:isUp() then spd.z = -(info.spd.z or 0) end
    if this.keyb:isDown() then spd.z = info.spd.z or 0 end
    if this.keyb:isLeft() then spd.x, this:dir().x = -(info.spd.x or 0), -1 end
    if this.keyb:isRight() then spd.x, this:dir().x = (info.spd.x or 0),  1 end
    
    this:spd(spd)
    
    return true
  end
  end,
  
  hitAll = function(hit) return function(this, scene)
    scene:getHits(this):each(function(actor) this:hit(actor, hit) end)
  end
  end,
  
  -- Triggers
  isKey = function(key) return F(function(this)
    return this.keyb and this.keyb:isKey(key)
  end)
  end,
  
  isFrame = function(nframe) return F(function(this)
    return this:curr():isStep() and this:curr():frame() == nframe
  end)
  end,
      
  isEnded = F(function(this) return this:curr():isEnded() end),
  isDied = F(function(this) return this.info.hp == 0 end),
  isFloor = F(function(this) return this.data:floor() end),
  isFall = F(function(this) return this:spd().y > 0 end),
  
  -- Customizable functions
  isHit = function(this, actor, state)
    state = state or this:state() 
    local f = Math.Sign(this:dir().x)
    local d = this:dist(actor)
    if (f ==  1 and this:pos().x < actor:pos().x) or
       (f == -1 and this:pos().x > actor:pos().x) then
      
      local x, z = (this.states[state]:dim().w * 0.5) + actor:rad(), actor:rad()
      return d.x < x and d.z < z
    end
    
    return false
  end,  
}
