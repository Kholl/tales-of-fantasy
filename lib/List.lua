--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Moo.List = function(class)
  return Moo.Class {
    list = nil,
    
    create = function(this, list) this.list = list or {} end,
    
    clear = function(this) this.list = {} end,
    size = function(this) return #this.list end,
    each = function(this, func) Moo.Each(this.list, func) end,
    
    trim = function(this, size)
      while (#this.list > size) do table.remove(this.list) end
      return this
    end,
    
    add = function(this, item) table.insert(this.list, item); return item end,
    add1st = function(this, item) table.insert(this.list, 1, item); return item end,
    addNew = function(this, params) return this:add(class.new(params)) end,    
      
    first = function(this) return this.list[1] end,
    last = function(this) return this.list[#this.list] end,
    sort = function(this, func) table.sort(this.list, func); return this end,
    
    map = function(this, func)
      local mapped = List(class).new()
      this:each(function(i, item) mapped[i] = func(item) end)
      return mapped
    end,
    
    reduce = function(this, func)
      local reduce = nil
      this:each(function(i, item) reduce = func(item, reduce) end)
      return reduce
    end,
    
    filter = function(this, func)
      local filtered = List(class).new()
      this:each(function(i, item)
        if func(item) then filtered:add(item) end
      end)
    
      return filtered
    end,    
  }
end
