AddCSLuaFile()

ENT.Type = "anim"
ENT.category = "General"

--ENT.editableProperties = {}

-- Set up the datatables
function ENT:SetupDataTables()
	local usedSlots = {
		String = 0,
		Bool = 0,
		Float = 0,
		Int = 0,
		Vector = 0,
		Angle = 0,
		Entity = 0,
	}

	-- Setup the attributes
	for id, attribute in pairs(self.editableProperties) do
		self:NetworkVar(attribute.type, usedSlots[attribute.type], id)
		if attribute.default then
			self["Set" .. id](self, attribute.default)
		end
		usedSlots[attribute.type] = usedSlots[attribute.type] + 1
	end
end

-- Get the current data
function ENT:getEditableProperties()
	local data = table.Copy(self.editableProperties)
	for id, attribute in pairs(data) do
		data[id].default = self["Get" .. id](self)
	end
	return data
end

if SERVER then
	-- Update the data
	function ENT:updateEditableProperties(newProperties)
		for id, attribute in pairs(self.editableProperties) do
			-- Cannot update an entity via form
			if attribute.type != "Entity" then
				self["Set" .. id](self, newProperties[id])
			end
		end
		if self.onUpdated then
			self:onUpdated()
		end
		Log(LOG_INFO, "Updated via Editable Properties", self:__tostring())
	end
end
