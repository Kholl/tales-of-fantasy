--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")
require("lib/game/ui/graphic/GraphicRules")
require("lib/game/ui/animator/Animator")

Graphic = Class {  
  graphics = Dependency("graphics"),
  
  list = nil,  
  data = nil,
  
  create = function(this, init)
    this.list = init.list or {}
    this.data = GraphicData.new(init)
  end,
  
  draw = function(this, area)
    if this.data:hide() then return end
    
    area = this.data:bounds(area)    
    List.each(this.list, function(item) item:draw(area) end)
  end,
  
  update = function(this, delta, parent, _, game)
    this.data:update(delta, this, game)
    List.each(this.list, function(item) item:update(delta, this, parent, game) end)
  end,

  anm = function(this, init) List.add(this.list, Animator.new(init)) end,
  add = function(this, item) List.add(this.list, item) end,
  rem = function(this, item) List.rem(this.list, item) end,
  has = function(this, key) return not (this.list[key] == nil) end,
  get = function(this, key) return this.list[key] end,
  run = function(this, key) this:get(key):run() end,
  stop = function(this, key) this:get(key):stop() end,
  
  dim = function(this, val) return this.data:dim(val) end,
  pos = function(this, val) return this.data:pos(val) end,
  dir = function(this, val) return this.data:dir(val) end,  
  color = function(this, val) return this.data:color(val) end,
  alpha = function(this, val) return this.data:alpha(val) end,
  bgColor = function(this, val) return this.data:bgColor(val) end,
  bgImage = function(this, val) return this.data:bgImage(val) end,
  bgAlpha = function(this, val) return this.data:bgAlpha(val) end,
  bdColor = function(this, val) return this.data:bdColor(val) end,
  time = function(this, val) return this.data:time(val) end,
  hide = function(this, val) return this.data:hide(val) end,
--  tmul = function(this, val) return this.data:tmul(val) end,
  
--  show = function(this) this.data:hide(false) end,
--  hide = function(this) this.data:hide(true) end,
--  stop = function(this) this.data:tmul(0) end,
--  play = function(this) this.data:tmul(1) end,
--  back = function(this) this.data:tmul(-1) end,
}