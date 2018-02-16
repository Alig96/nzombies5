local databaseClass = {}
databaseClass.tables = {}
databaseClass.tableIdCounter = {}

-- Table

function databaseClass:tableExists(tableId, suppress)
  if self.tables[tableId] then
    return true
  end
  if suppress == nil then
    Log(LOG_ERROR, "Table: '" .. tableId .. "' does not exist", "Framework:Database")
  end
  return false
end

function databaseClass:getNextUniqueId(tableId)
  if self:tableExists(tableId) then
    return self.tableIdCounter[tableId]
  end
end

function databaseClass:updateTableCounter(tableId)
  -- If we are auto incrementing then, increment
  if self.tableIdCounter[tableId] then
    self.tableIdCounter[tableId] = self.tableIdCounter[tableId] + 1
  end
end

function databaseClass:newTable(tableId, prototypeId)
  if !self:tableExists(tableId, true) then
    -- If we don't provide prototype id then we should make an auto-incrementing id system
    if modelId == nil then
      self.tableIdCounter[tableId] = 1
    end
    Log(LOG_DEBUG, "Table: '" .. tableId .. "' created", "Framework:Database")
    self.tables[tableId] = {}
    return tableId
  end
end

function databaseClass:deleteTable(tableId)
  if self:tableExists(tableId) then
    self.tables[tableId] = nil
    Log(LOG_DEBUG, "Table: '" .. tableId .. "' deleted", "Framework:Database")
  end
end

-- Row

function databaseClass:selectAllRows(tableId)
  if self:tableExists(tableId) then
    return self.tables[tableId]
  end

  return nil
end

function databaseClass:createRow(tableId, rowData, rowId)
  if self:tableExists(tableId) then
    if rowId == nil then
      rowId = self:getNextUniqueId(tableId)
    end
    if !self:hasRow(tableId, rowId) then
      self.tables[tableId][rowId] = rowData
      Log(LOG_DEBUG, "Created Row: '" .. rowId .. "' in table: " .. tableId, "Framework:Database")
      self:updateTableCounter(tableId)
      -- Return the id of the row that was inserted
      return rowId
    end
  else
    Log(LOG_ERROR, "Cannot Create Row: '" .. rowId .. "' in table: " .. tableId .. " because row already exists", "Framework:Database")
  end
end

function databaseClass:selectRow(tableId, rowId, suppress)
  if self:tableExists(tableId) then
    local row = self.tables[tableId][rowId]
    if row then
      if suppress == nil then
        Log(LOG_DEBUG, "Selected Row: '" .. rowId .. "' in table: " .. tableId, "Framework:Database")
      end
      return row
    end
  end

  if suppress == nil then
    Log(LOG_DEBUG, "Could not find Row: '" .. rowId .. "' in table: " .. tableId, "Framework:Database")
  end

  return nil
end

function databaseClass:hasRow(tableId, rowId)
  return self:selectRow(tableId, rowId, true) != nil
end

function databaseClass:updateRow(tableId, rowId, rowData)
  if self:tableExists(tableId) and self:hasRow(tableId, rowId) then
    self.tables[tableId][rowId] = rowData
    Log(LOG_DEBUG, "Updated Row: '" .. rowId .. "' in table: " .. tableId, "Framework:Database")
  else
    Log(LOG_ERROR, "Cannot Update Row: '" .. rowId .. "' in table: " .. tableId .. " because row does not exist", "Framework:Database")
  end
end

function databaseClass:deleteRow(tableId, rowId)
  if self:tableExists(tableId) and self:hasRow(tableId, rowId) then
    self.tables[tableId][rowId] = nil
    Log(LOG_DEBUG, "Deleted Row: '" .. rowId .. "' in table: " .. tableId, "Framework:Database")
  else
    Log(LOG_ERROR, "Cannot Delete Row: '" .. rowId .. "' in table: " .. tableId .. " because row does not exist", "Framework:Database")
  end
end

-- Assign the class table to the gel global
gel.Internal.Database = databaseClass
