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
  
  Property = function(attr, config)
    local trigger = config and config.trigger or false
    local use = config and config.use or false
    
    return function(obj, val)
      if val == nil then return obj[attr] end
      
      local pval = rawget(obj, attr)
      
      if use then val = use(val) end
      if not (pval == val) then
        if type(pval) == "table"
          then Moo.List.copy(obj[attr], val)
          else rawset(obj, attr, val)
        end
      end
      
      if not (pval == val) and trigger then
        obj[trigger](obj, val)
      end
      return obj
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
    
    Moo.List.copy(class, definition)
    
    class.new = Moo.Create(class)
    class.push = Moo.Push
    class.pull = Moo.Pull
    
    setmetatable(class, {
      __index = class.super or Moo.Err("Property or method '%s' is unknown"),
      __newindex = Moo.Err("Class is inmutable"),
    })

    return class
  end,
  
  Create = function(class)
    return function(init, custom)
      local instance = setmetatable({}, {__index = class})
      
      if type(init) == "string" then
        init = Moo.Load(init, instance)
        if custom then
          Moo.List.copy(init, custom)
        end
      end
      
      instance:create(init)
      return instance
    end
  end,
  
  Operator = function(operator)
    return function(value)
      return setmetatable(value, {
        __newindex = rawget(operator, "[?]") or nil,
        __concat = rawget(operator, "..") or nil,
        __index = rawget(operator, "[]") or nil,
        __call = rawget(operator, "()") or nil,
        __len  = rawget(operator, "#") or nil,
        __add  = rawget(operator, "+") or nil,
        __mul  = rawget(operator, "*") or nil,
        __sub  = rawget(operator, "-") or nil,
        __div  = rawget(operator, "/") or nil,
        __mod  = rawget(operator, "%") or nil,
        __pow  = rawget(operator, "^") or nil,
        __unm  = rawget(operator, "_") or nil,
        __le   = rawget(operator, "<=") or nil,
        __lt   = rawget(operator, "<") or nil,
      })
    end
  end,
  
  Push = function(instance, props)
    Moo.List.each(props, function(value, property) instance[property](instance, value) end)
    return instance
  end,
  
  Pull = function(instance, props)
    local values = {}
    Moo.List.each(props, function(property) values[property] = instance[property](instance) end)
    return values
  end,
  
  Import = function()
    Moo.List.each(Moo, function(value, key)
      if rawget(_G, key) == nil then rawset(_G, key, value) end
    end)
  end,
  
  Load = function(file)
    local func, errmsg = loadfile(file)      
    assert(func, errmsg)
    
    return func()
  end,
}

-- Foundation classes
require("lib/util/List")
require("lib/util/Func")
require("lib/util/Math")
require("lib/util/Vect")