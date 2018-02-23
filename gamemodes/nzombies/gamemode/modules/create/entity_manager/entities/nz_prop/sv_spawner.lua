local manager = {}

manager.id = "nz_prop"
manager.entityClass = "nz_prop"

function manager:onCreate(newEntity, entityData)
  local prop = entityData

  if prop.model == "models/props_c17/oildrum001.mdl" then return end

  newEntity:SetModel(prop.model)
  local position = newEntity:GetPos()
  position.z = position.z + newEntity:OBBMaxs().z
  newEntity:SetPos(position)
end

nz.entityManager:new(manager)
