--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

Game = {
  Anim = {
    Air = function(actor)
      return function(sprite)
        local k = actor:spd().y / actor.info.state.jmp.spd.y
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
  },
  
  PixelMap = {
    Pal = function(replace)
      return function (x, y, r, g, b, a)
        local key = string.format("%02x%02x%02x", r, g, b)
        local color = replace[key] or {r = r, g = g, b = b}
        return color.r, color.g, color.b, a
      end
    end,
  },
}

Game.assets = {}
Game.assets["high elf pal"] = {
  name = "~helf",
  func = Game.PixelMap.Pal{
    ["000000"] = {r =  34, g =  85, b =  51},
    ["223355"] = {r = 119, g =  68, b =  34},
    ["444477"] = {r = 153, g = 102, b =  68},
    ["445555"] = {r =  34, g = 136, b =  85},
    ["557777"] = {r =  68, g = 204, b = 136},
    ["6677aa"] = {r = 204, g = 136, b = 102},
    ["9999cc"] = {r = 255, g = 187, b = 136},
    ["ddddff"] = {r = 255, g = 221, b = 204},
  }
}

return Game