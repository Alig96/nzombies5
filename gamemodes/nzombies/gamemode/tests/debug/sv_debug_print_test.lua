local debugPrintTest = GUnit.Test:new("Debug > Print")

local function can_print_a_success_message()
  -- Create a debug message
  local debugPrint = nz.Debug.Print("success", "Test")

  -- Assert that it transforms the string
  GUnit.assert(debugPrint):shouldEqual("[Success] Test\n")
end

debugPrintTest:addSpec("can print a success message", can_print_a_success_message)

local function can_print_a_info_message()
  -- Create a debug message
  local debugPrint = nz.Debug.Print("info", "Test")

  -- Assert that it transforms the string
  GUnit.assert(debugPrint):shouldEqual("[Info] Test\n")
end

debugPrintTest:addSpec("can print a info message", can_print_a_info_message)

local function can_print_a_warning_message()
  -- Create a debug message
  local debugPrint = nz.Debug.Print("warning", "Test")

  -- Assert that it transforms the string
  GUnit.assert(debugPrint):shouldEqual("[Warning] Test\n")
end

debugPrintTest:addSpec("can print a warning message", can_print_a_warning_message)

local function can_print_a_danger_message()
  -- Create a debug message
  local debugPrint = nz.Debug.Print("danger", "Test")

  -- Assert that it transforms the string
  GUnit.assert(debugPrint):shouldEqual("[Danger] Test\n")
end

debugPrintTest:beforeAll(function ()
  -- Set it to debug mode
  nz.Debug.Environment:set(ENV_DEV)
end)

debugPrintTest:addSpec("can print a danger message", can_print_a_danger_message)
