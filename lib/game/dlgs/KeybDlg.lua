--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/List")

KeybDlg = Class {
  keyboard = Dependency("keyboard"),
  
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
    
  update = function(this, actor, scene)
    local delta = scene.delta
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
    
    Each(this.keys, function(key, cmd)
      if this.keyboard.isDown(key) then keypress, currlist[cmd] = true, true end
    end)
    
    Each(this.keys, function(key, cmd)
      if currlist[cmd] then this.currkey = this.currkey .. cmd end
    end)

    if keypress then this.idle = 0 else this.idle = this.idle +delta end
    return keypress
  end,
  
  addCurrKey = function(this)
    if this.currkey:len() == 0 then return end
    
    table.insert(this.list, this.currkey)
    
    this.key, this.match, this.matchlen = "", "", 0
    Each(this.list, function(key) this.key = key .. ">" .. this.key end)
      
      print(this.key)
  end,
  
  isChangedKey = function(this) return not (this.currkey:lower() == this.prevkey:lower()) end,  
  
  isUp = function(this) return this.keyboard.isDown(this.keys.u) end,
  isDown = function(this) return this.keyboard.isDown(this.keys.d) end,
  isLeft = function(this) return this.keyboard.isDown(this.keys.l) end,
  isRight = function(this) return this.keyboard.isDown(this.keys.r) end,
  isBtnA = function(this) return this.keyboard.isDown(this.keys.a) end,
  isBtnB = function(this) return this.keyboard.isDown(this.keys.b) end,

  isNoKey = function(this) return this.key:len() == 0 end,
  isKey = function(this, keys)
    if this:isNoKey() then return false end
    
    local isMatch = false
    Each(keys, function(key)
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
