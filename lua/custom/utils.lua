local M = {}

function M.deep_merge(tbl1, tbl2)
  local result = {}
  for k, v in pairs(tbl1) do
    if type(v) == 'table' and type(tbl2[k]) == "table" then
      result[k] = deep_merge(v, tbl2[k])
    else
      result[k] = v
    end
  end
  for k, v in pairs(tbl2) do
    if result[k] == nil then
      result[k] = v
    end
  end
  return result
end

function M.merge_configs(default_config, project_config)
  for key, value in pairs(project_config) do
    if type(value) == "table" then
      default_config[key] = merge_configs(default_config[key] or {}, value)
    else
      default_config[key] = value
    end
  end
  return default_config
end

return M
