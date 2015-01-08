--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Cache = Moo.Class {
  loader = nil,
  resources = nil,
  
  create = function(this, init)
    this.loader = init
    this.resources = {}
  end,
  
  get = function(this, kind, file)
    if not this.resources[file] then this.resources[file] = this.loader[kind](file) end
    return this.resources[file]
  end,
}