--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/List")

KeybDir = Class {
  keyboard = Dependency("keyboard"),
  
  keys = nil,
  set = nil,
  seq = nil,
  hash = nil,
  hashLast = nil,
  
  create = function(this, init)
    this.keys = List().new(init.keys or {})       
    this.set = {}
    this.seq = List().new{}
    this.hash = ""
    this.hashLast = ""
    this:reset()
  end,
    
  update = function(this, context)
        
    if not (this.hashLast == "") and
       not (this.hash == this.hashLast) then
       
      this.seq:add1st(Copy(this.set))
      this.seq:trim(6)
      this:reset()
    end

    this.hashLast = this.hash
    this.hash = ""
    
    this.keys:each(function(cmd, key)
        if not this.keyboard.isDown(key) then return end
        this.set[cmd] = this.set[cmd] +1
        this.set.idle = 0
        this.hash = this.hash .. "," .. cmd
      end)
    
    if this.hash == "" then this.set.idle = this.set.idle +1 end
    
    context.actor.info.key = this.set
    context.actor.info.keyseq = this.seq.list
  end,
  
  reset = function(this)
    this.set.idle = 0
    this.keys:each(function(cmd, key) this.set[cmd] = 0 end)
  end,
}
