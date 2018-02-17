local baseColors = {
  ["white"] = Color(255,255,255),
  ["gray-100"] = Color(248,249,250),
  ["gray-200"] = Color(233,236,239),
  ["gray-300"] = Color(222,226,230),
  ["gray-400"] = Color(206,212,218),
  ["gray-500"] = Color(173,181,189),
  ["gray-600"] = Color(108,117,125),
  ["gray-700"] = Color(273,80,87),
  ["gray-800"] = Color(52,58,64),
  ["gray-900"] = Color(33,37,41),
  ["black"] = Color(0,0,0),
}

local basicColors = {
  ["blue"] = Color(0,123,255),
  ["indigo"] = Color(102,16,242),
  ["purple"] = Color(111,66,193),
  ["pink"] = Color(232,62,140),
  ["red"] = Color(220,53,69),
  ["orange"] = Color(253,126,20),
  ["yellow"] = Color(255,193,7),
  ["green"] = Color(40,167,69),
  ["teal"] = Color(32,201,151),
  ["cyan"] = Color(23,162,184),
}

local textColors = {
  ["text-dark"] = baseColors["gray-900"],
  ["text-light"] = baseColors["white"]
}

-- Register all the colors
for id, color in pairs(baseColors) do
  gel.fw:newColor(id, color)
end

for id, color in pairs(basicColors) do
  gel.fw:newColor(id, color)
end

for id, color in pairs(textColors) do
  gel.fw:newColor(id, color)
end
