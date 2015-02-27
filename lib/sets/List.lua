--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

List = Moo.Class {
  list = nil,
  
  create = function(this, list) this.list = list or {} end,
  
  add = function(this, item) table.insert(this.list, item); return item end,
  sort = function(this, func) table.sort(this.list, func); return this end,
  each = function(this, func) for key, val in pairs(this.list) do func(val, key) end end,

  filter = function(this, func)
    local filtered = List.new()
    this:each(function(item) if func(item) then filtered:add(item) end end)
    return filtered
  end,
}

-- Alias
L = function(list) return List.new(list) end