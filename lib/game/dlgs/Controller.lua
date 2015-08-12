--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Controller = Class {
  MAXIDLE = 0.1,
  
  keys = nil,
  list = nil,
  currlist = nil,  
  key = nil,
  prevkey = nil,
  currkey = nil,
  idle = nil,
  match = nil,
  matchlen = nil,
  
  get = function(controller)
    if controller == "keyboard" then return Keyboard
    elseif controller == "gamepad" then return Gamepad
    end
  end,
  
  create = function(this, keys)
    this.keys = keys
    
    this.list = {}
    this.currlist = {}
    this.key = ""
    this.prevkey = ""
    this.currkey = ""
    this.idle = 0
    this.match = ""
    this.matchlen = 0
  end,
  
  update = function(this, delta, game)
    local keypress = this:updateCurrKey(delta)
        
    if this.idle >= Controller.MAXIDLE then
      this:resetState()
    end
    
    if this:isChangedKey() then this:addCurrKey() end
  end,
  
  updateCurrKey = function(this, delta)
    local keypress = false

    local currlist = {}
    this.prevkey, this.currkey = this.currkey, ""
    
    List.each(this.keys, function(key, cmd)
      if this:isDown(key) then keypress, currlist[cmd] = true, true end
    end)
    
    List.each(this.keys, function(key, cmd)
      if currlist[cmd] then this.currkey = this.currkey .. cmd end
    end)

    if keypress then this.idle = 0 else this.idle = this.idle +delta end
    return keypress
  end,
      
  resetState = function(this)
    this.idle = 0
    this.key, this.list = "", {}
    this.prevkey, this.currkey, this.currlist = "", "", {}
    this.match, this.matchlen = "", 0
  end,
  
  isChangedKey = function(this) return not (this.currkey:lower() == this.prevkey:lower()) end,  

  addCurrKey = function(this)
    if this.currkey:len() == 0 then return end
    
    table.insert(this.list, this.currkey)
    
    this.key, this.match, this.matchlen = "", "", 0
    List.each(this.list, function(key) this.key = key .. ">" .. this.key end)
  end,
  
  isKeypress = function(this, cmd) return this:isDown(this.keys[cmd]) end,

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
