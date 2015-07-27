--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Camera = Class {
  targets = nil,
  pos = nil,
  dst = nil,
  time = nil,
  
  create = function(this, init)
    this.targets = init and init.targets or {}
    this.pos = init and init.pos or {x = 0, y = 0, z = 0}
    this.dst = init and init.dst or {x = 0, y = 0, z = 0}
    this.time = init and init.time or 0.12
  end,
  
  draw = Nil,
  step = Nil,
  
  update = function(this, delta, scene, game)
    local pos = {x = 0, y = 0, z = 0}
    List.each(this.targets, function(target)
      local target = scene:actor(target)
      local targetpos = target:pos()
      pos = {
        x = pos.x + targetpos.x + (target:flip().h * 50),
        y = pos.y + targetpos.y - (target:dim("std").h * 0.5),
        z = pos.z + targetpos.z}
    end)
  
    this.dst = {
      x = pos.x / #this.targets,
      y = pos.y / #this.targets,
      z = pos.z / #this.targets}
    
    local lim = scene:lim()    
    local k = delta / this.time
    
    this.pos = {
      x = (this.pos.x * (1-k)) + (this.dst.x * k),
      y = (this.pos.y * (1-k)) + (this.dst.y * k),
      z = (this.pos.z * (1-k)) + (this.dst.z * k)}
    
    
    local off = {
      x = (game.w * 0.5) - (this.pos.x * scene:ratio().x),
      y = (game.h * 0.5) - (this.pos.z * scene:ratio().z) - (this.pos.y * scene:ratio().y)}
    
    scene:off(off)
  end,
  
  add = function(this, target) List.add(this.targets, target) end,
}