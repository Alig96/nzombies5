local logModelTest = GUnit.Test:new("[Framework] Models > Log")

local function can_create_log_model()
  local newLog = nz.Framework.newLog()

  -- Assert it has the defaults of the model.
  GUnit.assert(newLog.moduleName):shouldEqual("General")
end

logModelTest:addSpec("can create log model", can_create_log_model)
