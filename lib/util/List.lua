--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Moo.ListGenerator = function(iterator) return {
  last = function(list) return list[#list] end,
  
  add = function(list, item)
    table.insert(list, item)
    return item
  end,
  
  rem = function(list, item)
    local key = List.find(list, item)
    list[key] = nil
  end,
  
  empty = function(list)
    return #list == 0
  end,
  
  each = function(list, func)
    local res = {}
    for key, val in iterator(list) do
      res[key] = func(val, key)
    end
    return res
  end,

  filter = function(list, func)
    local res = {}
    for key, val in iterator(list) do
      if func(val, key) then res[key] = val end
    end
    return res
  end,
  
  select = function(list, func)
    for key, val in iterator(list) do
      if func(val, key) then return key end
    end
  end,
  
  sort = function(list, eval)
    table.sort(list, function(a, b)
        return eval(a) < eval(b)
      end)
    return list
  end,
  
  find = function(list, item)
    for key, val in iterator(list) do if val == item then return key end end
    return nil
  end,
  
  copy = function(dst, src)
    for key, val in iterator(src) do dst[key] = val end
    return dst
  end,
  
  divide = function(list)
    local keys, vals = {}, {}
    for key, val in iterator(src) do
      table.insert(keys, key)
      table.insert(vals, val)
    end
    
    return keys, vals
  end,
}
end

Moo.List = Moo.ListGenerator(pairs)
Moo.IndexList = Moo.ListGenerator(ipairs)