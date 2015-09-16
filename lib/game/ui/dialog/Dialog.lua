--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/frame/Frame")

DialogUnused = Class {
  super = Frame,
  
--  seqid = Property("_seqid", {trigger = "reload"}),

--  seq = nil,
--  seqtime = nil,
  
  create = function(this, init)
    Frame.create(this, init)    
--[[    
    this.seq = init.seq
    this.seqtime = init.seqtime      
    this:seqid(init.seqid or 1)
    
    this:get("out"):play(List.last(this.seqtime))
]]
  end,
  
  update = function(this, delta, parent, game)
    Frame.update(this, delta, game)

--    if this._seqid < #this.seqtime and this:time() > this.seqtime[this._seqid] then this:seqid(this._seqid +1) end
--    if this:get("out"):ended(this) then parent:rem(this) end
  end,
--[[  
  reload = function(this)
    local interval = this.seqtime[this._seqid] - (this.seqtime[this._seqid -1] or 0)
    this:get("text"):get("scr"):dur(interval -2) -- Two extra reading seconds
    
    List.each(this.seq[this._seqid], function(props, key)
      local item = this:get(key)
      item:push(props):time(0)
      item:get("out"):playTo(interval)
    end)
  end,
]]
}
