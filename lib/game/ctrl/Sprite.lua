--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/data/SpriteData")
require("lib/game/draw/SpriteDraw")

Sprite = Class {
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
  
  update = Nil,
  
  box = function(this) return this.data:box() end,
  rad = function(this) return this.data:rad() end,
  dim = function(this) return this.data:dim() end,
  pad = function(this) return this.data:pad() end,
  
  reset = function(this) this.data:reset() end,
    
  idle = function(this, actor, scene, game) end,
  play = function(this, actor, scene, game) this.data:incr(scene:frame()):limit() end,
  loop = function(this, actor, scene, game) this.data:incr(scene:frame()):loop() end,
  
  frame = function(this, frame) return this.data:get() end,
  isStep = function(this) return this.data.step end,
  isEnded = function(this) return this.data.ended end,
}

