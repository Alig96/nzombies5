local prototypeToolCategory = {}

prototypeToolCategory.id = 0
prototypeToolCategory.name = "BaseToolCategory"
prototypeToolCategory.advanced = false

-- Register this prototype as a model
nz.Framework.registerModel(prototypeToolCategory, "ToolCategory", {"id", "name", "advanced"})

local prototypeTool = {}

prototypeTool.id = 0
prototypeTool.name = "BaseTool"
prototypeTool.category = {}
prototypeTool.description = "This tool does nothing."
prototypeTool.instructions = {
  leftClick = "Do Nothing",
  rightClick = "Do Nothing",
}

function prototypeTool:onLeftClick(trace)
  print("Triggered: On Left Click")
  PrintTable(trace)
end

function prototypeTool:onRightClick(trace)
  print("Triggered: On Right Click")
  PrintTable(trace)
end

-- Register this prototype as a model
nz.Framework.registerModel(prototypeTool, "Tool", {"id", "name", "category", "description", "instructions", "onLeftClick", "onRightClick"})
