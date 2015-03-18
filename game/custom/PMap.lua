--[[
Tales Of Fantasy
@author Manuel Coll <mkhollv@gmail.com>
]]--

PMap = {
  Pal = function(replace)
    return function (x, y, r, g, b, a)
      local key = string.format("%02x%02x%02x", r, g, b)
      local color = replace[key] or {r = r, g = g, b = b}
      return color.r, color.g, color.b, a
    end
  end,
}