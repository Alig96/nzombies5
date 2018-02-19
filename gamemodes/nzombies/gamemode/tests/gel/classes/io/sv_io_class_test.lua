local ioClassTest = GUnit.Test:new("[Framework] IO Class")

local testFilePath = "test.txt"
local testTable = {"entry1", "entry2"}

local function can_write_a_table_to_a_file()
  -- Assert the file doesn't already exist
  GUnit.assert(file.Exists(testFilePath, "DATA")):shouldEqual(false)

  -- Use the library to write the test table to the file system
  gel.fw:writeTableToFile(testFilePath, testTable)

  -- Assert the file now does exist
  GUnit.assert(file.Exists(testFilePath, "DATA")):shouldEqual(true)
end

local function can_read_a_table_from_a_file()
  -- Use the library to write the test table to the file system
  gel.fw:writeTableToFile(testFilePath, testTable)
  -- Use the library to read back the table
  local fileTable = gel.fw:readTableFromFile(testFilePath)

  -- Assert the 2 table's entries are the same
  GUnit.assert(testTable[1]):shouldEqual(fileTable[1])
  GUnit.assert(testTable[2]):shouldEqual(fileTable[2])
end

ioClassTest:addSpec("can write a table to a file", can_write_a_table_to_a_file)
ioClassTest:addSpec("can read a table from a file", can_read_a_table_from_a_file)

ioClassTest:afterAll(function()
  -- Clean up the test file
  file.Delete(testFilePath)
end)
