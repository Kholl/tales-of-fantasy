--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/State")
require("lib/game/data/ActorData")

Actor = Class {
  super = State,
  
  data = nil,
  info = nil,
  rules = nil,
  keybdlg = nil,
  actrdlg = nil,
  
  create = function(this, init)
    State.create(this, init)
    this.data = ActorData.new(init)
    this.rules = init.rules or {}
    this.info = init and init.info or {}
    this.keybdlg = false
    this.actrdlg = ActorDlg.new(init.rules)
    
    -- External functions
    this.priority = init.priority or Actor.priority
    this.isTarget = init.isTarget or Actor.isTarget
    this.isHit = init.isHit or Actor.isHit
    this.hit = init.hit or Actor.hit
  end,
  
  draw = function(this, scene)
    State.draw(this, this.data, scene)
  end,
  
  update = function(this, scene)
    State.update(this, scene)
    
    if this.keybdlg then this.keybdlg:update(this, scene) end
    this.actrdlg:update(this, scene)
  end,
  
  keyb = function(this, init) this.keybdlg = KeybDlg.new(init) end,
  
  dim = function(this) return this:curr():dim() end,
  box = function(this) return this:curr():box() end,
  rad = function(this) return this:curr():rad() end,
  dir = function(this, val) return this.data:dir(val) end,
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  mass = function(this, val) return this.data:mass(val) end,
  floor = function(this, val) return this.data:floor(val) end,
  target = function(this, val) return this.data:target(val) end,  
  
  -- Delegates
  check = function(this, scene)
    if this:target() then return end
    
    local filter = function(actor) return this:isTarget(actor) end
    local sorter = function(a, b) return this:priority(a) < this:priority(b) end
    local target = scene:getActors(selectFunc):filter(filter):sort(sorter):first()
    this:target(target)
  end,
    
  think = function(this, scene)
    local dist = this:dist()
    local eucl = this:eucl()
    local sel, best = "std", 0
    local actions = this.rules[this:state()]
    
    Each(actions, function(func, action)
      local state = this.info.state[action]
      if not state or not state.rng or not Math.InLim(eucl, state.rng) then return end
      
      local val = state.spd and state.spd.x or Math.Rand(1, 10)
      if best < val then sel, best = action, val end
    end)
  
    local state = this.info.state[sel]
    if not (this:state() == sel) then this:start(sel) end    
    
    if state and state.spd then
      local dir = {x = -Math.Sign(dist.x), y = 1, z = -Math.Sign(dist.z)}
      local spd = this:spd()
      
      spd.x = dir.x * (state.spd.x or spd.x)
      spd.y = dir.y * (state.spd.y or spd.y)
      spd.z = dir.z * (state.spd.z or spd.z)      
      
      this:dir(dir)
      this:spd(spd)
    end
  end,
  
  attack = function(info) return function(this, scene)
    scene:getHits(this):each(function(actor) this:hit(actor, info) end)
  end
  end,

  move = function(info) return function(this, scene)
    local spd = this:spd()
    if info.spd.y then spd.y = info.spd.y end
    if this.keybdlg:isUp() then spd.z = -(info.spd.z or 0) end
    if this.keybdlg:isDown() then spd.z = info.spd.z or 0 end
    if this.keybdlg:isLeft() then spd.x, this:dir().x = -info.spd.x or 0, -1 end
    if this.keybdlg:isRight() then spd.x, this:dir().x = info.spd.x or 0,  1 end
    
    this:spd(spd)
  end
  end,
  
  isKey = function(key, cmd) return function(this)
    local event = this.keybdlg and this.keybdlg:isKey(key)
    if event and cmd then cmd(this, scene) end
    return event
  end
  end,
  
  isFrame = function(nframe, cmd) return function(this, scene)
    local event = this:curr():isStep() and this:curr():frame() == nframe
    if event and cmd then cmd(this, scene) end
    return event
  end
  end,
      
  isChain = function(key) return function(this)
    return this.keybdlg and this.keybdlg:isKey(key) and this:isEnded()
  end
  end,

  isNoKey = function(this) return this.keybdlg and this.keybdlg:isNoKey() end,
  isEnded = function(this) return this:curr():isEnded() end,
  isDied = function(this) return this.info.hp == 0 end,
  isFloor = function(this) return this.data:floor() end,
  noFloor = function(this) return not this:isFloor() end,
  isFall = function(this) return this:spd().y > 0 end,
  
  dist = function(this, actor)
    actor = actor or this:target()
    local a, b = this:pos(), actor:pos()
    return {x = math.abs(a.x - b.x), z = math.abs(a.z - b.z)}
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
  
  priority = function(this, actor) return this:eucl(actor) end,
  isTarget = function(this, actor) return not (this == actor) end,
  isHit = function(this, actor)
    local f = Math.Sign(this:dir().x)
    local d = this:dist(actor)
    if (f ==  1 and this:pos().x < actor:pos().x) or
       (f == -1 and this:pos().x > actor:pos().x) then
      
      local x, z = (this:dim().w * 0.5) + actor:rad(), actor:rad()
      return d.x < x and d.z < z
    end
    
    return false
  end,
  
  hit = function(this, actor, hit)
    actor:face(this)
    actor:target(this)
    actor:start(action or "hit")
      
    local dist = this:dist(actor)
    local dirx = Math.Sign(dist.x)
      
    local force = hit.force or {}
    if force.x then actor:spd().x = dirx * hit.force.x end
    if force.y then actor:spd().y = hit.force.y end
    if force.z then actor:spd().z = hit.force.z end
  end,
}
