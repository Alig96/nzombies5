GM.Name = "nZombies v5"
GM.Author = "Alig96"
GM.Email = "N/A"
GM.Website = "N/A"

NZ_VERSION = "5.0.0"

--Team Constants
TEAM_SPECS = 1
TEAM_PLAYERS = 2

-- Main Table
nz = {}

--Setup Teams
team.SetUp(TEAM_SPECS, "Spectators", Color(255, 255, 255))
team.SetUp(TEAM_PLAYERS, "Players", Color(255, 0, 0))
