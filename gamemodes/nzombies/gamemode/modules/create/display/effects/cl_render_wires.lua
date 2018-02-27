local wireMaterial = Material("cable/redlaser")
local redColor = gel.fw:getColor("red")
local linkableEntities = {
  "nz_enemy_spawner"
}

hook.Add("PostDrawOpaqueRenderables", "Render_test",function()
  if !nz.Mode:isCreate() then return end
  -- Loop through the entities list
  for _, entClass in pairs(linkableEntities) do
    -- Loop through each entity that can be linked
    for _, linkableEntity in pairs(ents.FindByClass(entClass)) do
      -- If the entity is a linkable entity
      if IsValid(linkableEntity) and linkableEntity.isLinkable then
        local originPosition = linkableEntity:GetPos()
        local linkAreaEntity = linkableEntity:GetLinkEntity()
        if IsValid(linkAreaEntity) then
          render.SetMaterial(wireMaterial)
          render.DrawBeam(originPosition, linkAreaEntity:GetPos(), 10, 1, 1, redColor)
        end
      end
    end
  end
end)
