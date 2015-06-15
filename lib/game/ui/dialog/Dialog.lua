--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

require("lib/game/ui/frame/Frame")

Dialog = Class {
  super = Frame,
  
  anim = nil,
  seq = nil,
  seqid = nil,
  seqtime = nil,
  
  create = function(this, init)
    Frame.create(this, init)
    
    this.anim = init.anim
    this.seq = init.seq
    this.seqtime = init.seqtime
    
    this:sequence(0)
  end,
  
  update = function(this, delta, parent, game)
    Frame.update(this, delta, game)    
    if this:time() <= this.seqtime[this.seqid] then return end
    
    if this.seqid < #this.seqtime then
      this:sequence(this.seqid +1)
    else
      parent:rem(this)
    end
  end,
  
  sequence = function(this, seqid)
    this.seqid = seqid % (#this.seq +1)
    
    List.each(this.seq[this.seqid], function(props, item)
      this:get(item):push(props):time(0)
    end)
  end,
}
