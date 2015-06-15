--[[
Moo Object Oriented framework for LUA
@author Manuel Coll <mkhollv@gmail.com>
]]--

ImageFX = {
  mapPixel = function(palette)
    local pal = Dependency("resource"):get("file", palette)
    
    return function(image)      
      image:mapPixel(function (x, y, r, g, b, a)
        local key = string.format("%02x%02x%02x", r, g, b)
        local color = pal[key] or {r = r, g = g, b = b}
        return color.r, color.g, color.b, a
      end)
      
      return image
    end
  end,
}