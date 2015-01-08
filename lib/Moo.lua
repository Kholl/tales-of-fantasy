--[[
Moo Object Oriented framework for LUA
Basic class definition

@author Manuel Coll <mkhollv@gmail.com>
]]--

Moo = {
  Nil = setmetatable({}, {
    __index = function(t, key, val) return t end,
    __call = function(t) return t end,
  }),

  Set = function(key, index) return not (rawget(key, index) == nil) end,

  Err = function(message)
    return function(t, key, val) error(string.format(message, key)) end
  end,

  Each = function(table, func)
    local result = {}
    table = table or {}
    for key, val in pairs(table) do result[key] = func(key, val) end
    
    return result
  end,
  
  Find = function(table, value)
    local result = false
    for key, val in pairs(table) do if val == value then return key end end
    
    return false
  end,
  
  Copy = function(src)
    local dst = {}
    for key, val in pairs(src) do dst[key] = val end
    return dst
  end,

  Range = function(initial, final, func)
    local result = {}
    for i = initial, final do result[i] = func(i) end
    
    return result
  end,
  
  Debug = function(desc, src, tab)
    tab = tab or 0
    
    print(string.rep("\t", tab) .. desc)
    Moo.Each(src, function(key, val)
      if type(val) == "table" then
        Moo.Debug(key, val, tab +1)
      else
        print(string.rep("\t", tab +1) .. key .. "=" .. val)
      end
    end)
  end,
  
  Property = function(attr)
    return function(obj, val)
      if not (val == nil) then obj[attr] = val end
      return obj[attr]
    end
  end,
  
  Dependency = function(name)
    if not Moo.__Deps then Moo.__Deps = {} end
    if Moo.__Deps[name] then return Moo.__Deps[name] end
    
    return function(value)
      Moo.__Deps[name] = value
    end
  end,

  Class = function(definition)
    local class = {}
    class.create = Nil
    class.super = Object
    
    Moo.Each(definition, function(attribute, value)
      if attribute == "super" then
        class[attribute] = value -- Class keywords
      else
        class[attribute] = value -- Class method
      end
    end)
    
    class.new = Moo.Create(class)
    
    setmetatable(class, {
      __index = class.super or Moo.Err("Property or method '%s' is unknown"),
      __newindex = Moo.Err("Class is inmutable"),
    })

    return class
  end,
  
  Create = function(class)
    return function(init)
      local instance = setmetatable({}, {__index = class})
      
      if type(init) == "string" then
        init = Moo.Load{this = instance, require = require}(init)
      end
    
      instance:create(init)
      return instance
    end
  end,
  
  Import = function()
    Moo.Each(Moo, function(key, value)
      if rawget(_G, key) == nil then rawset(_G, key, value) end
    end)
  end,
  
  Load = function(env)
    return function(file)
      local func, errmsg = loadfile(file)
      assert(func, errmsg)      
      
      return setfenv(func, env)()
    end
  end,
}

-- Foundation classes
require("lib/Math")
require("lib/List")
require("lib/Rule")
require("lib/Cache")