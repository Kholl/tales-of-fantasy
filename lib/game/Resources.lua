--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Resources = Class {
  filesystem = Dependency("filesystem"),
  
  loader = nil,
  resources = nil,
  
  create = function(this, init)
    this.loader = init
    this.resources = {}
  end,
  
  safeload = function(this, kind, name)
    local ok, res = pcall(function() return this.loader[kind](name) end)
    if ok then return res end
  end,
  
  get = function(this, kind, name)
    if not this.resources[name] then this:set(name, this:safeload(kind, name)) end
    return this.resources[name]
  end,
  
  set = function(this, name, value)
    this.resources[name] = value
    return value
  end,
  
  getFx = function(this, kind, name)
      return function(post, command)
        local postname = string.format("%s~%s", name, post)
        local res = this:get(this, postname)
        if not res then
          res = command(this:safeload(kind, name))
          this.filesystem.mkdir(postname)
          this.filesystem.remove(postname)
          res:encode(postname)
          this:set(postname, res)
        end
        
        return res
    end
  end,
}