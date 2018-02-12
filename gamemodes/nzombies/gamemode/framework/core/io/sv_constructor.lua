IO = {}

function IO:writeTableToFile(filePath, tableData)
  file.Write(filePath, util.TableToJSON(tableData))
  Log(LOG_INFO, "Successfully wrote table to: " .. filePath, "Framework:IO")

  return true
end

function IO:readTableFromFile(filePath)
  if !file.Exists(filePath, "DATA") then
    Log(LOG_ERROR, "Could not find file: " .. filePath, "Framework:IO")
  else
    Log(LOG_INFO, "Found File; Loading contents from: " .. filePath, "Framework:IO")
    return util.JSONToTable(file.Read(filePath, "DATA"))
  end
end

-- Assign the meta table to the nz global
nz.Framework.IO = setmetatable(IO, {})
