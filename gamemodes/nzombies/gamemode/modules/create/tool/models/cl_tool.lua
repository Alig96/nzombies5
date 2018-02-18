local prototypeTool = {}

prototypeTool.id = "BaseTool"
prototypeTool.name = "#base_tool_name"
prototypeTool.description = "#base_tool_description"
prototypeTool.instructions = {
  leftClick = "#base_tool_instructions_left",
  rightClick = "#base_tool_instructions_right",
}

function prototypeTool:onLeftClick(trace)
  PrintTable(trace)
end

function prototypeTool:onRightClick(trace)
  PrintTable(trace)
end

-- Register this prototype as a model
gel.fw:newModel("Tool", prototypeTool, {"id", "name", "description", "instructions", "onLeftClick", "onRightClick"})
