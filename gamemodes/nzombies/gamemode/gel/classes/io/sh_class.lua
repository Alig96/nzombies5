ioClass = {}

function ioClass:writeTableToFile(filePath, tableData)
	file.Write(filePath, util.TableToJSON(tableData))
	Log(LOG_INFO, "Successfully wrote table to: " .. filePath, "Framework:io")
	return true
end

function ioClass:readTableFromFile(filePath)
	if !file.Exists(filePath, "DATA") then
		Log(LOG_ERROR, "Could not find file: " .. filePath, "Framework:io")
	else
		Log(LOG_DEBUG, "Found File; Loading contents from: " .. filePath, "Framework:io")
		return util.JSONToTable(file.Read(filePath, "DATA"))
	end
end

-- Assign the class table to the gel global
gel.Internal.io = ioClass

-- Create shortcut
function gel.fw:writeTableToFile(...)
	return gel.Internal.io:writeTableToFile(...)
end

-- Create shortcut
function gel.fw:readTableFromFile(...)
	return gel.Internal.io:readTableFromFile(...)
end
