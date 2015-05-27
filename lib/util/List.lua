--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

List = {
  add = function(list, item) table.insert(list, item); return item end,
  rem = function(list, item) table.remove(list, List.find(list, item)) end,
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
  
  sort = function(list, eval)
    table.sort(list, function(a, b)
        return eval(a) < eval(b)
      end)
    return list
  end,
  
  find = function(list, item)
    for key, val in pairs(list) do if val == item then return key end end
    return nil
  end,
  
  copyTo = function(dst, src)
    for key, val in pairs(src) do dst[key] = val end
    return dst
  end,
}