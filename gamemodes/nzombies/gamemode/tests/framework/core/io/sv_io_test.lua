local IOTest = GUnit.Test:new("[Framework] IO")

local filePath = "nz/test.txt"

local function can_write_a_table_to_a_file()
  -- Assert the file doesn't already exist
  GUnit.assert(file.Exists(filePath, "DATA")):shouldEqual(false)

  -- Use the library to write the test table to the file system
  local hardTable = {"entry1", "entry2"}
  nz.Framework.IO:writeTableToFile(filePath, hardTable)

  -- Assert the file now does exist
  GUnit.assert(file.Exists(filePath, "DATA")):shouldEqual(true)
end

local function can_read_a_table_from_a_file()
  -- Use the library to write the test table to the file system
  local hardTable = {"entry1", "entry2"}
  nz.Framework.IO:writeTableToFile(filePath, hardTable)

  local fileTable = nz.Framework.IO:readTableFromFile(filePath)

  -- Assert the 2 tables are the same
  GUnit.assert(hardTable[1]):shouldEqual(fileTable[1])
  GUnit.assert(hardTable[2]):shouldEqual(fileTable[2])
end


IOTest:beforeAll(function ()
  -- Set it to dev mode
  nz.Framework.Environment:setDev()
end)

IOTest:afterAll(function ()
  -- Clean up the test file
  file.Delete(filePath)
end)


IOTest:addSpec("can write table to file", can_write_a_table_to_a_file)
IOTest:addSpec("can read table from file", can_read_a_table_from_a_file)
