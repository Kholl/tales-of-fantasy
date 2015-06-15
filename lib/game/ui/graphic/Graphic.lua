--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/graphic/GraphicData")
require("lib/game/ui/animator/Animator")

Graphic = Class {  
  graphics = Dependency("graphics"),
  
  list = nil,  
  data = nil,
  script = Nil,
  
  create = function(this, init)
    this.list = init.list or {}
    this.data = GraphicData.new(init)
    
    if init.script then
      this.script = ScriptDlg.new(init)
    end
  end,
  
  draw = function(this, parent)
    if this.data:hidden() then return end
    local area = this.data:area(parent)
        
    List.each(this.list, function(item) item:draw(area) end)
  end,
  
  step = function(this, group, game)
    List.each(this.list, function(item) item:step(this, game) end)
  end,
  
  update = function(this, delta, game)
    this.data:update(delta, this, game)
    this.script:update(delta, this, game)
    List.each(this.list, function(item) item:update(delta, this, game) end)
  end,

  anm = function(this, init) List.add(this.list, Animator.new(init)) end,
  add = function(this, item) List.add(this.list, item) end,
  rem = function(this, item) List.rem(this.list, item) end,
  has = function(this, key) return not (this.list[key] == nil) end,
  get = function(this, key) return this.list[key] end,
  
  dim = function(this, val) return this.data:dim(val) end,
  pos = function(this, val) return this.data:pos(val) end,
  dir = function(this, val) return this.data:dir(val) end,  
  color = function(this, val) return this.data:color(val) end,
  alpha = function(this, val) return this.data:alpha(val) end,
  bgColor = function(this, val) return this.data:bgColor(val) end,
  bgImage = function(this, val) return this.data:bgImage(val) end,
  bgAlpha = function(this, val) return this.data:bgAlpha(val) end,
  bdColor = function(this, val) return this.data:bdColor(val) end,
  hidden = function(this, val) return this.data:hidden(val) end,
  time = function(this, val) return this.data:time(val) end,
}