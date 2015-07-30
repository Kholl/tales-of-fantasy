--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/actor/ActorScript")
require("lib/game/stage/actor/ActorData")
require("lib/game/stage/actor/ActorDlg")
require("lib/game/stage/state/State")

Actor = Class {
  data = nil,
  list = nil,
  
  spriteData = nil,
  spriteDraw = nil,
  
  create = function(this, init)
    this.data = ActorData.new(init)
      
    this.spriteData = {}    
    this.spriteDraw = {}
    
    this.list = init and init.list or {}
    
    List.each(init and init.states, function(state, key)
      this.spriteDraw[key] = SpriteDraw.new{
        res = state.res or init.res,
        pmap = state.pmap or init.pmap,
        nframes = state.nframes or init.nframes,
        hframes = state.hframes or init.hframes,
        dim = state.dim or init.dim}
      
      this.spriteData[key] = SpriteData.new{
        box = state.box or init.box,
        dim = state.dim or init.dim,
        pad = state.pad or init.pad,
        
        anim = state.anim,
        frate = state.frate,
        nframes = state.nframes}      
    end)
  end,
  
  draw = function(this, scene)
    this:getDraw():draw(this:getData(), this.data, scene)
    List.each(this.list, function(item) item:draw(this, scene) end)
  end,
  
  step = function(this, scene, game)
    this:getData():step(this, scene, game)
    List.each(this.list, function(item) item:step(this, scene, game) end)
  end,
  
  update = function(this, delta, scene, game)
    this:getData():update(delta, this, scene, game)
    List.each(this.list, function(item) item:update(delta, this, scene, game) end)
  end,
  
  getDraw = function(this, state)
    state = state or this.data:state()
    return this.spriteDraw[state]
  end,
  
  getData = function(this, state)
    state = state or this.data:state()
    return this.spriteData[state]
  end,
  
  add = function(this, item) List.add(this.list, item) end,
  rem = function(this, item) List.rem(this.list, item) end,
  has = function(this, key) return not (this.list[key] == nil) end,
  get = function(this, key) return this.list[key] or Nil end,
  
  dim = function(this, state) return this:getData(state):dim() end,
  box = function(this, state) return this:getData(state):box() end,
  pad = function(this, state) return this:getData(state):pad() end,
  frame = function(this) return this:getData():frame() end,
  isStep = function(this) return this:getData():isStep() end,
  isEnded = function(this) return this:getData():isEnded() end,
    
  pos = function(this, val) return this.data:pos(val) end,    
  spd = function(this, val) return this.data:spd(val) end,
  rad = function(this, val) return this.data:rad(val) end,    
  flip = function(this, val) return this.data:flip(val) end,
  mass = function(this, val) return this.data:mass(val) end,
  target = function(this, val) return this.data:target(val) end,
  player = function(this, val) return this.data:player(val) end,
  
  dir = function(this, val)
    if val == nil then return this.data:dir() end
    
    local flip = this.data:flip()
    if not (val.x == nil or val.x == 0) then flip.h = val.x end
    
    this.data:flip(flip)
    return this.data:dir(val)
  end,
    
  state = function(this, val)
    local state = this.data:state()
    if (val == nil) or (val == state) then return state end
    
    this:getData(val):reset()
    return this.data:state(val)
  end,
  
  extra = function(this, key, val)
    local extra = this.data:extra()
    if (val == nil) or (val == extra[key]) then return extra[key] end    
    
    this.data:extra()[key] = val
    return val
  end,

  distrel = function(this, actor)
    actor = actor or this:target() or this
    local a, b = this:pos(), actor:pos()
    return {x = a.x - b.x, z = a.z - b.z}
  end,
  
  distout = function(this, actor)
    local dist = this:distrel(actor)
    local dhit = this:disthit(actor)
    return {x = math.abs(dist.x) - dhit.x, z = math.abs(dist.z) - dhit.z}
  end,
  
  disthit = function(this, actor)
    actor = actor or this:target() or this
    return {
      x = (this:dim().w + actor:box().w) * 0.5,
      z = math.max(this:rad(), actor:rad()) }
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
    local drel = actor:distrel(this)
    local dhit = actor:disthit(this)
    local dir = {x = Math.Sign(drel.x), z = Math.Sign(drel.z)}
    if drel.z > -dhit.z and drel.z < dhit.z then dir.z = 0 end
    
    return this:dir(dir)
  end,
    
  force = function(this, actor, force)
    force = force or {}
    
    local dirx = Math.Sign(this:pos().x - actor:pos().x)  
    if force.x then this:spd().x = dirx * force.x end
    if force.y then this:spd().y = force.y end
    if force.z then this:spd().z = force.z end
  end,
}
