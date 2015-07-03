--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

Anim = {
  Air = function(max)
    return function(sprite, actor, scene)
      local k = actor:spd().y / max
      return (sprite.data._nframes) * (1 - k) * 0.5
    end
  end,

  Air2 = function()
    return function(sprite, actor, scene)
      if actor:spd().y < 0 then return 0 else return 1 end
    end
  end,

  Air3 = function(threshold)
    return function(sprite, actor, scene)
      local value = actor:spd().y
      
      if value < -threshold then return 0
      elseif value > threshold then return 2
      else return 1
      end
    end
  end,
}