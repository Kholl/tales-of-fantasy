--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Keyboard = Class {
  super = Controller,
  
  keyboard = Dependency("keyboard"),
    
  create = function(this, init)
    Controller.create(this, init.keys)
  end,
  
  isDown = function(this, key)
    return this.keyboard.isDown(key)
  end,
}
