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
    local res = nil
    for key, val in iterator(list) do
      if (res == nil) and func(val, key) then res = key end
    end
    return res
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
  
  copyTo = function(dst, src)
    for key, val in iterator(src) do dst[key] = val end
    return dst
  end,
  
  print = function(list)
    for key, val in iterator(list) do io.write(string.format("%s\t%s\n", key, val)) end
  end,
}
end

Moo.List = Moo.ListGenerator(pairs)
Moo.IndexList = Moo.ListGenerator(ipairs)