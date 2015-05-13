--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

KeybDlg = Class {
  keyboard = Dependency("keyboard"),
  ruleset = "keybrules",

  list = nil,
  currlist = nil,  
  key = nil,
  prevkey = nil,
  currkey = nil,
  minpress = nil,
  idle = nil,
  maxidle = nil,
  match = nil,
  matchlen = nil,
  
  create = function(this, init)
    this.keys = init or {}
    
    this.list = {}
    this.currlist = {}
    this.key = ""
    this.prevkey = ""
    this.currkey = ""
    this.minpress = init.minpress or 1
    this.idle = 0
    this.maxidle = init.maxidle or 0.1
    this.match = ""
    this.matchlen = 0
  end,
  
  step = Nil,
    
  update = function(this, delta, actor, scene, game)
    local keypress = this:updateCurrKey(delta)
        
    if this.idle >= this.maxidle then
      this:resetState()
    end
    
    if this:isChangedKey() then this:addCurrKey() end
  end,
  
  resetState = function(this)
    this.idle = 0
    this.key, this.list = "", {}
    this.prevkey, this.currkey, this.currlist = "", "", {}
    this.match, this.matchlen = "", 0
  end,
    
  updateCurrKey = function(this, delta)
    local keypress = false

    local currlist = {}
    this.prevkey, this.currkey = this.currkey, ""
    
    List.each(this.keys, function(key, cmd)
      if this.keyboard.isDown(key) then keypress, currlist[cmd] = true, true end
    end)
    
    List.each(this.keys, function(key, cmd)
      if currlist[cmd] then this.currkey = this.currkey .. cmd end
    end)

    if keypress then this.idle = 0 else this.idle = this.idle +delta end
    return keypress
  end,
  
  addCurrKey = function(this)
    if this.currkey:len() == 0 then return end
    
    table.insert(this.list, this.currkey)
    
    this.key, this.match, this.matchlen = "", "", 0
    List.each(this.list, function(key) this.key = key .. ">" .. this.key end)
  end,
  
  isChangedKey = function(this) return not (this.currkey:lower() == this.prevkey:lower()) end,  
  
  direction = function(this, actor)
    local kx, kz = 0, 0
    if this.keyboard.isDown(this.keys.l) then kx = -1 end
    if this.keyboard.isDown(this.keys.r) then kx =  1 end
    if this.keyboard.isDown(this.keys.u) then kz = -1 end
    if this.keyboard.isDown(this.keys.d) then kz =  1 end
    return kx, kz
  end,
  
  isKey = function(this, keys)
    
    -- Return FALSE if no key was pressed.
    -- Return TRUE if any keys were pressed and none specified.
    if this.key:len() == 0 then return false
    elseif keys == nil then return true
    end
    
    local isMatch = false
    List.each(keys, function(key)
      if isMatch then return end
      if key:len() < this.matchlen then return end
            
      local pos, matchlen = this.key:find(key)
      if pos == 1 and matchlen >= this.matchlen then
        isMatch, this.match, this.matchlen = true, key, matchlen
      end
    end)
    
    return isMatch
  end,  
}
