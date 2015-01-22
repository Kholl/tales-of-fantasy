--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ctrl/Image")

Gui = {}
Gui.Bar = Class {
  super = Image,
  
  target = Property("_target"),
  wmax = nil,
  prop = nil,
  
  create = function(this, init)
    Image.create(this, init)
    this.prop = init.prop
    this.wmax = init.dim.w
  end,
  
  update = function(this)
    local info = this:target().info
    local val = info[this.prop.val]
    local max = info[this.prop.max]
    this.data:dim().w = Math.Lim(this.wmax * val / max, {min = 0})
  end,
}

return Gui