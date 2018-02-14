local databaseClassTest = GUnit.Test:new("[Framework] Database Class")

local function can_create_a_new_database_table()
  local tableId = "New Table"

  gel.Internal.Database:newTable(tableId)

  GUnit.assert(gel.Internal.Database:tableExists(tableId)):shouldEqual(true)
end

local function can_create_a_new_table_row()
  local tableId = "New Table"
  gel.Internal.Database:newTable(tableId)

  gel.Internal.Database:createRow(tableId, {name = "newName"})
  local requestedData = gel.Internal.Database:selectRow(tableId, 1)

  GUnit.assert(requestedData.name):shouldEqual("newName")
end

local function can_update_a_table_row()
  local tableId = "New Table"
  gel.Internal.Database:newTable(tableId)

  gel.Internal.Database:createRow(tableId, {name = "newName"})
  gel.Internal.Database:updateRow(tableId, 1, {name = "updatedName"})

  local requestedData = gel.Internal.Database:selectRow(tableId, 1)

  GUnit.assert(requestedData.name):shouldEqual("updatedName")
end

local function can_delete_a_table_row()
  local tableId = "New Table"
  gel.Internal.Database:newTable(tableId)

  gel.Internal.Database:createRow(tableId, {name = "newName"})
  gel.Internal.Database:deleteRow(tableId, 1)

  local requestedData = gel.Internal.Database:selectRow(tableId, 1)

  GUnit.assert(requestedData):shouldEqual(nil)
end

local function if_we_delete_a_row_it_should_still_count_up()
  local tableId = "New Table"
  gel.Internal.Database:newTable(tableId)

  gel.Internal.Database:createRow(tableId, {name = "newName"})
  gel.Internal.Database:createRow(tableId, {name = "newEntry"})
  gel.Internal.Database:deleteRow(tableId, 2)
  local newRowId = gel.Internal.Database:createRow(tableId, {name = "newEntry2"})

  local requestedData = gel.Internal.Database:selectRow(tableId, 2)

  -- Assert that because the table removed an item, it still counted up and went to 3
  GUnit.assert(requestedData):shouldEqual(nil)
  GUnit.assert(newRowId):shouldNotEqual(2)
  GUnit.assert(newRowId):shouldEqual(3)
end

databaseClassTest:addSpec("can create a new database table", can_create_a_new_database_table)
databaseClassTest:addSpec("can create a new table row", can_create_a_new_table_row)
databaseClassTest:addSpec("can update a new table row", can_update_a_table_row)
databaseClassTest:addSpec("can delete a new table row", can_delete_a_table_row)
databaseClassTest:addSpec("if we delete a row, it should still count up", if_we_delete_a_row_it_should_still_count_up)

local function afterEach()
  gel.Internal.Database:clearDatabase()
end

databaseClassTest:afterEach(afterEach)
