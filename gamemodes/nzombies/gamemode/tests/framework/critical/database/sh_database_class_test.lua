local databaseClassTest = GUnit.Test:new("[Framework] Database Class")

local testTableId = "New Table"

local function can_create_a_new_database_table()
  gel.Internal.Database:newTable(testTableId)

  GUnit.assert(gel.Internal.Database:tableExists(testTableId)):shouldEqual(true)
end

local function can_create_a_new_table_row()
  gel.Internal.Database:newTable(testTableId)

  gel.Internal.Database:createRow(testTableId, {name = "newName"})
  local requestedData = gel.Internal.Database:selectRow(testTableId, 1)

  GUnit.assert(requestedData.name):shouldEqual("newName")
end

local function can_update_a_table_row()
  gel.Internal.Database:newTable(testTableId)

  gel.Internal.Database:createRow(testTableId, {name = "newName"})
  gel.Internal.Database:updateRow(testTableId, 1, {name = "updatedName"})

  local requestedData = gel.Internal.Database:selectRow(testTableId, 1)

  GUnit.assert(requestedData.name):shouldEqual("updatedName")
end

local function can_delete_a_table_row()
  gel.Internal.Database:newTable(testTableId)

  gel.Internal.Database:createRow(testTableId, {name = "newName"})
  gel.Internal.Database:deleteRow(testTableId, 1)

  local requestedData = gel.Internal.Database:selectRow(testTableId, 1)

  GUnit.assert(requestedData):shouldEqual(nil)
end

local function if_we_delete_a_row_it_should_still_count_up()
  gel.Internal.Database:newTable(testTableId)

  gel.Internal.Database:createRow(testTableId, {name = "newName"})
  gel.Internal.Database:createRow(testTableId, {name = "newEntry"})
  gel.Internal.Database:deleteRow(testTableId, 2)
  local newRowId = gel.Internal.Database:createRow(testTableId, {name = "newEntry2"})

  local requestedData = gel.Internal.Database:selectRow(testTableId, 2)

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
  -- Clear the test table
  gel.Internal.Database:deleteTable(testTableId)
end

databaseClassTest:afterEach(afterEach)
