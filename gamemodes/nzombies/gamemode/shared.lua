GM.Name = "nZombies v5"
GM.Author = "Alig96"
GM.Email = "N/A"
GM.Website = "N/A"

NZ_VERSION = "5.0.0"

-- Environments Constants
ENV_DEV = 0
ENV_PRIVATE = 1
ENV_PUBLIC = 2

-- Mode Constants
MODE_PLAY = 0
MODE_CREATE = 1

-- Game Constants
GAME_INIT = 0
GAME_READY = 1
GAME_PROG = 2
GAME_FINISHED = 3

-- Round Constants
ROUND_INIT = 0
ROUND_PREP = 1
ROUND_PROG = 2
ROUND_FINISHED = 3

--Team Constants
TEAM_SPECS = 1
TEAM_PLAYERS = 2

--Setup Teams
team.SetUp(TEAM_SPECS, "Spectators", Color(255, 255, 255))
team.SetUp(TEAM_PLAYERS, "Players", Color(255, 0, 0))
