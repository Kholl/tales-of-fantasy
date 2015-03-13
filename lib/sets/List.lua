--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

List = {
  add = function(list, item) table.insert(list, item); return item end,
  sort = function(list, func) table.sort(list, func); return this end,
  
  each = function(list, func)
    local res = {}
    for key, val in pairs(list) do res[key] = func(val, key) end
    return res
  end,

  filter = function(list, func)
    local res = {}
    for key, val in pairs(list) do if func(val) then res[key] = val end end
    return res
  end,
}