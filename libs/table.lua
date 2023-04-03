local Table = {}

function Table.deep_copy(orig)
    local copy
    if type(orig) == "table" then
        copy = {}
        for k, v in next, orig, nil do
            copy[Table.deep_copy(k)] = Table.deep_copy(v)
        end
        setmetatable(copy, Table.deep_copy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

function Table.has_key(table, key)
  return table[key] ~= nil
end

function Table.dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k,v in pairs(o) do
      if type(k) ~= 'number' then k = '"'..k..'"' end
      s = s .. '['..k..'] = ' .. Table.dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end

function Table.remove_value(tbl, value)
  for i = #tbl, 1, -1 do
    if tbl[i] == value then
      table.remove(tbl, i)
    end
  end
end

function Table.all_values_non_number(table)
  for key, value in pairs(table) do
    if type(value) == "number" then
      return false
    end
  end
  return true
end

return Table