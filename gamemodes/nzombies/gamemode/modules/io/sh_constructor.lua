-- Constructor
nz.IO = {}

-- Check if the nz folder exists
if !file.Exists( "nz/", "DATA" ) and SERVER then
	file.CreateDir( "nz" )
end

-- Check if the nz/env folder exists
if !file.Exists( "nz/env", "DATA" ) and SERVER then
	file.CreateDir( "nz/env" )
end

-- Check if the nz/env folder exists
if !file.Exists( "nz/env/examples", "DATA" ) and SERVER then
	file.CreateDir( "nz/env/examples" )
end
