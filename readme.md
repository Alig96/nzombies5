# nZombies 5 [![Build Status](https://travis-ci.org/Alig96/nzombies5.svg?branch=master)](https://travis-ci.org/Alig96/nzombies5)

A full recode from scratch of nZombies utilizing [nZombies v3](https://github.com/Alig96/nzombies) & [nZombies v4](https://github.com/Zet0rz/nzombies) by Zet0rz & Lolleko.

## Requirements
Ensure these are installed on both Server & Client
- Garry's Mod
- Counter Strike: Source

## Install nZombies (Standard)
- Download and Extract the `nzombies5-master` folder into your addons.
- Rename `nzombies5-master` folder to `nzombies5`.

## Play nZombies
Just want to play nZombies? Follow these instructions.

### Single Player
- Follow the standard install instructions above.
- Launch `Garry's Mod`.
- In the bottom right, click and change the gamemode to `nZombies`.
- Click `Start New Game`.
- Choose any map.
- Wait to get into the game.
- `Play Instructions`

## Developer
Want to help contribute to nZombies? Follow these instructions.

### Install a local GMod Server
- Follow the instructions [here](https://wiki.garrysmod.com/page/Hosting_A_Dedicated_Server).
- Install [GUnit](https://github.com/Alig96/GUnit) into your server's addons.

### Install nZombies (Git)
- Fork the repository so you can track your changes.
- Open your terminal in the local GMod server's addon folder.
- Run: `git clone https://github.com/<YOUR USERNAME HERE>/nzombies5.git nzombies5`

### Change the nZombies environment to "Developer Mode"
- Navigate to: `garrysmod/data/nz/env/current_enviroment.txt`
- Edit this file to mimic: `garrysmod/data/nz/env/examples/dev.txt`
- If you don't see these files, delete the folder: `garrysmod/data/nz/env/` & launch the server to regenerate the structure.
- If you were successful in setting up Developer Mode, you should see: `[Success] [Environment] Internal Environment was set to: Development`
- (Wiki Page for environment files)

### Running Unit Tests
- Ensure you have GUnit installed properly.
- Type `test-only nzombies5` into server console. (Tip: This is also bound to the console command `qt`)
- All tests should pass, if they aren't then the version of nZombies is unstable.

### Feature Development
If you are developing a new feature/module, then it *MUST* come with an associated unit test to prove it works. See: `gamemodes/nzombies/tests/` for help.
