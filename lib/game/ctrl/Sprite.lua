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
  
  update = function(this, scene)
    if type(this.anim) == "string" then this[this.anim](this, scene)
    elseif type(this.anim) == "function" then this.data:set(this.anim(this))
    end
  end,
  
  box = function(this) return this.data:box() end,
  rad = function(this) return this.data:rad() end,
  dim = function(this) return this.data:dim() end,
  pad = function(this) return this.data:pad() end,
  
  reset = function(this) this.data:reset() end,
    
  idle = function(this, scene) end,
  play = function(this, scene) this.data:incr(scene.frame):limit() end,
  loop = function(this, scene) this.data:incr(scene.frame):loop() end,
  
  frame = function(this, frame) return this.data:get() end,
  isEnded = function(this) return this.data.ended end,
}

