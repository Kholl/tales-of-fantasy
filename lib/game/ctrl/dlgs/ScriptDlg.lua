--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ScriptDlg = Moo.Class {
  state = nil,
  commands = nil,
  
  create = function(this, init)
    this.commands = init.commands or {}
    this.state = "start"
  end,
  
  update = function(this, object)
    local command = this.commands[this.state] or {}
    this.state = command(object)
  end,
}