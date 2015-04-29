--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

FX = {
  MapPixel = function(replace)
    return function(image)
      image:mapPixel(function (x, y, r, g, b, a)
        local key = string.format("%02x%02x%02x", r, g, b)
        local color = replace[key] or {r = r, g = g, b = b}
        return color.r, color.g, color.b, a
      end)
      
      return image
    end
  end,
}