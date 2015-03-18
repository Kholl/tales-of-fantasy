--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ActorDlg = Moo.Class {
  rules = nil,
  keybrules = nil,
  autorules = nil,
  
  create = function(this, init)
    this.rules = init.rules or {}
    this.keybrules = init.keybrules or {}
    this.autorules = init.autorules or {}
  end,
  
  update = function(this, actor, scene)
    
    this:execute(actor, scene, this.rules)
    
    if actor:isKeyb() then this:execute(actor, scene, this.keybrules)
    elseif actor:isAuto() then this:execute(actor, scene, this.autorules)
--  elseif actor:isScrp() then this:execute(this.scrprules[state])
    end
  end,
  
  execute = function(this, actor, scene, rules)    
    local state = actor:state()
    local stateRules = rules[state] or {}
    List.each(stateRules, function(rule, action)
      if rule(actor, scene)
        and actor.states[action]
        and not (actor:state() == action) then
        
        actor:start(action)
      end
    end)
  end,
}