local modelClassTest = GUnit.Test:new("[Framework] Model Class")

local testModelId = "TestModel"

local function cannot_create_a_new_model_without_an_id()
  local newModel = gel.Internal.Model:new()

  GUnit.assert(newModel):shouldEqual(false)
end

local function cannot_create_a_new_model_without_a_prototype_class()
  local newModel = gel.Internal.Model:new(testModelId)

  GUnit.assert(newModel):shouldEqual(false)
end

local function can_make_a_new_model_item_with_id_and_prototype()
  local testModel = gel.Internal.Model:new(testModelId, {name = "BaseTestModel"}, {"name"})

  local newTestItem1 = testModel:make("newTestItem1")
  local newTestItem2 = testModel:make("newTestItem2")

  GUnit.assert(newTestItem1.name):shouldEqual("newTestItem1")
  GUnit.assert(newTestItem2.name):shouldEqual("newTestItem2")
end

local function can_create_then_find_a_new_model_item()
  local testModel = gel.Internal.Model:new(testModelId, {name = "BaseTestModel"}, {"name"})

  local newTestItem = testModel:create("newTestItem1")
  local foundItem = testModel:find(newTestItem.id)

  GUnit.assert(newTestItem.name):shouldEqual(foundItem.name)
  GUnit.assert(foundItem.id):shouldEqual(1)
end

local function can_create_then_update_a_new_model_item()
  local testModel = gel.Internal.Model:new(testModelId, {name = "BaseTestModel"}, {"name"})

  local newTestItem = testModel:create("newTestItem1")
  -- Change this item's name
  local changedTestItem = table.Copy(newTestItem)
  changedTestItem.name = "new name of item"

  -- Send an update
  local updatedTestItem = testModel:update(newTestItem.id, changedTestItem)

  -- The ids should still be the same
  GUnit.assert(updatedTestItem.id):shouldEqual(newTestItem.id)
  -- But the name should've updated and not be the same as the original
  GUnit.assert(updatedTestItem.name):shouldNotEqual(newTestItem.name)
end

local function can_create_then_delete_a_new_model_item()
  local testModel = gel.Internal.Model:new(testModelId, {name = "BaseTestModel"}, {"name"})

  local newTestItem = testModel:create("newTestItem1")
  -- Send a delete
  local deletedTestItem = testModel:delete(newTestItem.id)

  -- It shouldn't exist anymore
  GUnit.assert(deletedTestItem):shouldEqual(nil)

  -- Do a search
  local findTestItem = testModel:find(newTestItem.id)

  -- It shouldn't exist anymore
  GUnit.assert(findTestItem):shouldEqual(nil)
end

local function can_get_all_items_from_a_model()
  local testModel = gel.Internal.Model:new(testModelId, {name = "BaseTestModel"}, {"name"})

  testModel:create("newTestItem1")
  testModel:create("newTestItem2")
  testModel:create("newTestItem3")

  local allItems = testModel:all()

  -- We should have 3 items returned
  GUnit.assert(#allItems):shouldEqual(3)
end

modelClassTest:addSpec("cannot create a new model without an id", cannot_create_a_new_model_without_an_id)
modelClassTest:addSpec("cannot create a new model without a prototype class", cannot_create_a_new_model_without_a_prototype_class)
modelClassTest:addSpec("can make new model item with id and prototype", can_make_a_new_model_item_with_id_and_prototype)
modelClassTest:addSpec("can create then find a new model item in database", can_create_then_find_a_new_model_item)
modelClassTest:addSpec("can create then update a model item in database", can_create_then_update_a_new_model_item)
modelClassTest:addSpec("can create then delete a model item in database", can_create_then_delete_a_new_model_item)
modelClassTest:addSpec("can get all items in database from model", can_get_all_items_from_a_model)

local function afterEach()
  gel.Internal.Model:delete(testModelId)
end

modelClassTest:afterEach(afterEach)
