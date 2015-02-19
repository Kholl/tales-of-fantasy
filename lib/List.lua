--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Moo.List = function(class)
  return Moo.Class {
    list = nil,
    
    create = function(this, list) this.list = list or {} end,
    
    clear = function(this) this.list = {} end,
    empty = function(this) return this:size() == 0 end,
    size = function(this) return #this.list end,
    each = function(this, func) Moo.Each(this.list, func) end,
    
    trim = function(this, size)
      while (#this.list > size) do table.remove(this.list) end
      return this
    end,
    
    add = function(this, item) table.insert(this.list, item); return item end,
    addAt = function(this, item, index) table.insert(this.list, index, item); return item end,
    add1st = function(this, item) table.insert(this.list, 1, item); return item end,
    addNew = function(this, init) return this:add(class.new(init)) end,    
      
    first = function(this) return this.list[1] end,
    last = function(this) return this.list[#this.list] end,
    sort = function(this, func) table.sort(this.list, func); return this end,
    
    map = function(this, func)
      local mapped = List(class).new()
      this:each(function(item, i) mapped:addAt(i, func(item)) end)
      return mapped
    end,
    
    reduce = function(this, func)
      local reduce = nil
      this:each(function(item) reduce = func(item, reduce) end)
      return reduce
    end,
    
    all = function(this, func)
      local all = true
      this:each(function(item) all = all and func(item) end)
      return all
    end,
    
    any = function(this, func)
      local any = false
      this:each(function(item) any = any or func(item) end)
      return any
    end,
    
    filter = function(this, func)
      local filtered = List(class).new()
      this:each(function(item)
        if func(item) then filtered:add(item) end
      end)
    
      return filtered
    end,    
  }
end
