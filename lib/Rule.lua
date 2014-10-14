--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

Rule = Moo.Class {
  chk = nil,
  cmd = nil,
  
  create = function(this, init)
    this.chk = init and init.chk
    this.cmd = init and init.cmd
  end,
  
  execute = function(this, env)
    local vars = {}
    local exec = setfenv(this.chk, env)(vars)
    if exec then setfenv(this.cmd, env)(vars) end
  end,
}
