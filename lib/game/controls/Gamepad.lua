--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Gamepad = Class {
  super = Controller,
  
  joystick = Dependency("joystick"),
  
  pad = nil,
    
  create = function(this, init)
    Controller.create(this, init.keys)
    this.pad = init.pad or 1
  end,
  
  update = function(this, delta, game)
    Controller.update(this, delta, game)
  end,
  
  isDown = function(this, key)
    local x, y, z = this.joystick.getAxes(this.pad)
    
    if key == "right" then return x > 0
    elseif key == "left" then return x < 0
    elseif key == "up" then return y < 0
    elseif key == "down" then return y > 0
    else return this.joystick.isDown(this.pad, key)
    end
  end,
}
