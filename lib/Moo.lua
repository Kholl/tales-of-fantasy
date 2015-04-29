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

  Err = function(message)
    return function(t, key, val) error(string.format(message, key)) end
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
    
    List.each(definition, function(value, attribute)
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
      local instance = setmetatable({}, {
        __index = rawget(class, "[]") or class,
        __newindex = rawget(class, "[?]") or nil,
        __concat = rawget(class, "..") or nil,
        __call = rawget(class, "()") or nil,
        __le   = rawget(class, "<=") or nil,
        __lt   = rawget(class, "<") or nil,
        __len  = rawget(class, "#") or nil,
        __add  = rawget(class, "+") or nil,
        __mul  = rawget(class, "*") or nil,
        __sub  = rawget(class, "-") or nil,
        __div  = rawget(class, "/") or nil,
        __mod  = rawget(class, "%") or nil,
        __pow  = rawget(class, "^") or nil,
        __unm  = rawget(class, "_") or nil,
      })
      
      if type(init) == "string" then
        init = Moo.Load(init, instance)
      end
      
      instance:create(init)
      return instance
    end
  end,
  
  Import = function()
    List.each(Moo, function(value, key)
      if rawget(_G, key) == nil then rawset(_G, key, value) end
    end)
  end,
  
  Load = function(file, instance)
    local func, errmsg = loadfile(file)      
    assert(func, errmsg)
    
    return func()
  end,
}

-- Foundation classes
require("lib/util/List")
require("lib/util/Func")
require("lib/util/Vect")
require("lib/util/Math")