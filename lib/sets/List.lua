--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

List = {
  add = function(list, item) table.insert(list, item); return item end,
  sort = function(list, func) table.sort(list, func); return this end,
  each = function(list, func) for key, val in pairs(list) do func(val, key) end end,

  filter = function(list, func)
    local filtered = {}
    List.each(list, function(item) if func(item) then List.add(filtered, item) end end)
    return filtered
  end,
}