--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--
      
return {
  all = {
    notarget,
    target{
      std = {
        wlk = true, jmp = true, run = true, blk = true,
        atk = true, atkalt = true, atkup = true, atkrnd = true,
      },
      atk = {atksq1 = true},
      atksq1 = {atksq2 = true},
      atksq2 = {atksq3 = true},
      wlk = {wlk = true, jmp = true, run = true},
      run = {run = true, jmp = true, atkrun = true},
      runend = {dodge = true},
      jmp = {atkjmp = true},
      blk = {blk = true},
    },
  },
}