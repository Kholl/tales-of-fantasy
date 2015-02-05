--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/List")

KeybDlg = Class {
  KeyMap = {"b", "a", "d", "u", "l", "r"}, -- rludab
  
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
    this:checkMoves(actor)
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
      if this.keyboard.isDown(key) then
        keypress, currlist[cmd] = true, true
      end
    end)
    
    Each(KeybDlg.KeyMap, function(cmd)
      if currlist[cmd] then
        this.currkey = this.currkey .. cmd
      end
    end)

    if keypress then this.idle = 0 else this.idle = this.idle +delta end
    return keypress
  end,
  
  addCurrKey = function(this)
    if this.currkey:len() == 0 then return end
    
    table.insert(this.list, this.currkey)
    
    this.key, this.match, this.matchlen = "", "", 0
    Each(this.list, function(key) this.key = this.key .. ">" .. key end)
  end,
  
  checkMoves = function(this, actor)
    local moves = actor.moves[actor:state()]
    Each(moves, function(action, keyset)
      if this:isKeyset(keyset) then actor:action(action) end
    end)
  end,

  isKeyset = function(this, keyset)
    if this.key:len() == 0 then return end
    if keyset:len() < this.matchlen then return end
    
    local isMatch = false
    local keyrev = this.key:reverse()
    local pos, matchlen = keyrev:find(keyset)
    if pos == 1 and matchlen >= this.matchlen then
      isMatch, this.match, this.matchlen = true, keyset, matchlen
    end
    
    return isMatch
  end,
  
  isNoKeyset = function(this) return this.key:len() == 0 end,
  
  isChangedKey = function(this) return not (this.currkey:lower() == this.prevkey:lower()) end,  
}
