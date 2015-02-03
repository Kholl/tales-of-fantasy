--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/State")
require("lib/game/data/ActorData")

Actor = Class {
  super = State,
  
  data = nil,
  dlgs = nil,
  info = nil,
  keyb = nil,
  keyrule = nil,
  actrule = nil,
  
  create = function(this, init)
    State.create(this, init)
    this.data = ActorData.new(init)
    this.dlgs = List().new()
    this.info = init and init.info or {}
    this.keyb = false
    this.keyrule = false
    this.actrule = false
  end,
  
  draw = function(this, scene)
    State.draw(this, this.data, scene)
  end,
  
  update = function(this, scene)
    State.update(this, scene)
    
    local context = {
      actor = this,
      scene = scene,
      Math = Math,
      List = List,
      Each = Each,
      Find = Find,
      Copy = Copy,
      Range = Range,
      Game = Game,
      print = print,
    }
    
    if this.keyb then
      this.keyb:update(context)
      this.keyrule:update(context)
    end
    
    if this.actrule then 
      this.actrule:update(context)
    end
  
    this:action(false)
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
  action = function(this, val) return this.data:action(val) end,
  
  setKeyb = function(this, keyset, keyrule)
    this.keyb = KeybDlg.new(keyset)
    this.keyrule = ActorDlg.new(keyrule)
  end,
  
  setRule = function(this, init)
    this.actrule = ActorDlg.new(init)
  end,
  
  add = function(this, delegate) return this.dlgs:add(delegate) end,
  
  isNoKeyset = function(this) return this.keyb:isNoKeyset() end,
  isKeyset = function(this, keyset) return this.keyb:isKeyset(keyset) end,
    
  dist = function(this, actor)
    actor = actor or this:target()
    return Math.Dist(this:pos(), actor:pos())
  end,
  
  eucl = function(this, actor)
    local d = this:dist(actor)
    return math.sqrt(d.x*d.x + d.y*d.y + d.z*d.z)
  end,
  
  angle = function(this, actor)
    actor = actor or this:target()
    local angle = Math.Angle(this:pos(), actor:pos())
    return {x = math.cos(angle), z = math.sin(angle)}
  end,
  
  face = function(this, actor)
    actor = actor or this:target()
    this:dir().x = Math.Sign(actor:pos().x - this:pos().x)
    return this
  end,
  
  facing = function(this, actor)
    actor = actor or this:target()
    return (this:dir().x * actor:dir().x) == -1
  end,
    
  hitbox = function(this)
    local pos, box = this:pos(), this:box()
    return {x = pos.x - box.w*0.5, y = pos.y + pos.z - box.h, w = box.w, h = box.h}      
  end,
}
