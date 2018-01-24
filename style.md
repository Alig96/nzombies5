# nZombies Style Guide

## Comments
- Must use the `--` syntax, NOT `//`.
- Space after the `--`.

## Variables
- Local Variable Convention: `lowerCamelCase`
- Class Variable Convention: `UpperCamelCase`
- Strings should use double quotes: `"String"` not single quotes: `'String'`.
- Constants: Should be written in uppercase characters separated by underscores. Constant names may also contain digits if appropriate, but not as the first character.

## Functions/Methods
- Format: `nz.<ModuleName>.<functionName>`.
- Module Name Convention: `UpperCamelCase`
- Function Name Convention: `lowerCamelCase`
- Anything that is to be accessed by another module, must attach to the `nz` global namespace.
- Capitalize the module name & each function word.

## Tests
- The local function name must briefly describe what it is doing separated by underscores.
