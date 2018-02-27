local englishLanguage = gel.fw:newLanguage("english", "English", true)

-- Basic
englishLanguage:translate("#welcome", "Welcome to nZombies")

-- Mode
englishLanguage:translate("#survival_mode", "Survival Mode")
englishLanguage:translate("#create_mode", "Create Mode")

-- Tools
-- General
englishLanguage:translate("#no_tool_selected", "Hold Q to select a tool...")
-- Entity Editor Tool
englishLanguage:translate("#tool_entity_editor", "Entity Editor")
englishLanguage:translate("#tool_entity_editor_description", "Allows you to edit the properties of an entity")
englishLanguage:translate("#tool_entity_editor_instructions_left", "Edit Entity")
englishLanguage:translate("#tool_entity_editor_instructions_right", "None")

-- Entity Creator Tool
englishLanguage:translate("#tool_entity_creator", "Entity Creator")
englishLanguage:translate("#tool_entity_creator_description", "Allows you to create an entity")
englishLanguage:translate("#tool_entity_creator_instructions_left", "Create Entity")
englishLanguage:translate("#tool_entity_creator_instructions_right", "None")

-- Area Link Tool
englishLanguage:translate("#tool_area_linker", "Area Linker")
englishLanguage:translate("#tool_area_linker_description", "Allows you to link entities to a 'Area Link' entity")
englishLanguage:translate("#tool_area_linker_instructions_left", "Paste 'Area Link' to a Entity")
englishLanguage:translate("#tool_area_linker_instructions_right", "Copy 'Area Link' Entity ID")

-- Entity Remover Tool
englishLanguage:translate("#tool_entity_remover", "Entity Remover")
englishLanguage:translate("#tool_entity_remover_description", "Allows you to remove an entity")
englishLanguage:translate("#tool_entity_remover_instructions_left", "Remove Entity")
englishLanguage:translate("#tool_entity_remover_instructions_right", "None")
