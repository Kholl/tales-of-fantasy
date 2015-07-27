--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/stage/sprite/SpriteData")
require("lib/game/stage/sprite/SpriteDraw")

SpriteUnused = Class {
  drawable = nil,
  data = nil,
  anim = nil,
  
  create = function(this, init)
    this.drawable = SpriteDraw.new(init)    
    this.data = SpriteData.new(init)    
    this.anim = (init and init.anim) or "idle"
  end,
  
  draw = function(this, imageData, scene)
    this.drawable:draw(this.data, imageData, scene)
  end,
  
  step = function(this, actor, scene, game)
    if type(this.anim) == "string" then this[this.anim](this, actor, scene, game)
    elseif type(this.anim) == "function" then this.data:set(this.anim(this, actor, scene, game))
    end
  end,
  
  update = function(this, delta, actor, scene, game)
    this.data:time(this.data:time() + delta)
  end,
  
  box = function(this, val) return this.data:box(val) end,
  rad = function(this, val) return this.data:rad(val) end,
  dim = function(this, val) return this.data:dim(val) end,
  pad = function(this, val) return this.data:pad(val) end,
  
  reset = function(this) this.data:reset() end,
    
  idle = function(this, actor, scene, game) end,
  play = function(this, actor, scene, game) this.data:incr(scene:frame()):limit() end,
  loop = function(this, actor, scene, game) this.data:incr(scene:frame()):loop() end,
  
  frame = function(this, frame) return this.data:get() end,
  isStep = function(this) return this.data:isStep() end,
  isEnded = function(this) return this.data:isEnded() end,
}

