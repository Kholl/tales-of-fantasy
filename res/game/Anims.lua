--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

return {
  Air = function(actor, max)
    return function(sprite)
      local k = actor:spd().y / max
      return (sprite.data.nframes) * (1 - k) * 0.5
    end
  end,

  Air2 = function(actor)
    return function(sprite)
      if actor:spd().y < 0 then return 0 else return 1 end
    end
  end,

  Air3 = function(actor, threshold)
    return function(sprite)
      local value = actor:spd().y
      
      if value < -threshold then return 0
      elseif value > threshold then return 2
      else return 1
      end
    end
  end,
}