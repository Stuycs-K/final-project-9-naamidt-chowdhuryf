# Work Log

## Taamim Naamid

### 5/22/23

CW - Worked on implementing the Pokemon class and started the Pokedex\
HW - Added functionality to the Pokedex, a text file with sample Pokemon, and added leveling for Pokemon

### 5/23/23

CW - Worked a bit on the Pokedex and fleshed out the concepts of moves and a movedex with Bell\
HW - Added the type chart in the Pokedex and a damage calculator

### 5/24/23

CW - Worked on the foundation of adding moveslots, natures, and independent stats\
HW - Finished that up along with organization of data, couldn't do too much today since my ankle is sprained

### 5/25/23

CW - Worked on debugging, adjustments, and a little bit of Trainer\
HW - Massive debugging pain, testing going well and continuing to add Trainer stuff and starting on battling

### 5/26-29/23

HW - Worked on battling, encounters, the bag, basic items (healing, not held), and some bug fixing

### 5/30/23

CW - Updating the csv to make it more practical and talked with Bell about the UI side of things\
HW - Looked and after an unreasonable amount of time finally found a good csv folder that has every move and every movepool

### 5/31/23 - 6/1/23

HW - Absolute overhaul of data, all pokemon data and moves and sprites and everything included\
    (except some sprites, why is the showdown api not updated for key pokemon)\
    Also worked on making things work, like adding functionality to movepool, evs are gainable, so is exp, evolutions work, etc\
    Also lots of debugging for the demo, battles still dont work :(

### 6/2-4/23

HW - Discussed with Bell how we want to finalize the project, since the Demo is in a very unfinalized state, and what we should do to get there

### 6/5/23

HW - Complete overhaul of battling since it was broken maybe, bag will also get a redesign soon to align with battle better

### 6/6/23

CW - Updated Bell on what happened in class and coordinated something we needed to add in battles\
HW - Added the field for Bell in the Battle class as well as allowing learnsets to have multiple moves learned even if they are\
counted as "the same level"


### 6/7/23

CW - Presented Demo and talked about some future plans with Bell
HW - Drafted implementation for stat stage boosts/status effects on notepad

### 6/8/23

HW - Continued to draft implementation and trying to not do everything manually

### 6/9/23

CW - Realized that it was pointless and thought of how to add everything to the spreadsheed manually and manageably\
HW - Started adding some things in manually before getting into issues since I forgot some moves could have multiple effects

### 6/10-12/23

HW - Working on actually added stat stage boosts, status effects, better turn-based system, AI, more sprites, spreadsheets\
making diagrams for how the game will actually work, designing and coding the pokemon to demonstrate features in cheats,\
helped Bell with some UI stuff that needed to be fixed and copium rushed the final project since I designed neither the Map\
nor the UI so I didn't know how to implement the Events class properly


## Fishan Chowdhury (Bell)

### 5/23/23

CW - Started work on the Move class
HW - Finished Move class, needs testing

### 5/24/23

CW - Fixed a couple of repo erros and merge conflicts, and then added some more methods for moves
HW - Started testing with new setup; internet cut out for a while so progress was limited

### 5/25/23

CW - Unsuccesful testing of moves, pokedex, and pokedex followed by debugging, followed by succesful tests
HW - Untangling merge conflicts, followed by map work; added a mapmaker file but still need actual programming and scrolling function


### 5/26/23

CW - Wasn't able to do too much, was busy being yelled at and being clarified on how to do the mapmaker properly
HW - Made a proper mapmaker that reads files and produces maps based on the code with a UI that for now only quits

### 5/30/23

CW - Fixed flickering effect of map and started work on BattleUI
HW - Continued work on BattleUI and found an updated csv with pokemon data

### 5/31/23 - 6/1/23

HW - continued working on BattleUI and finished a few buttons, flickering, and started fighting buttons

### 6/2 - 6/4

HW - 

## Dev Log:


### Working Features
Walking around (There are walls where there looks like there’s a path for separate reasons)\
Battling, for the most part\
The implemented game mechanics (evs, ivs, “abilities”, stab, damage calcs, stat calcs, catching calcs, basically any calc that exists in our game is implemented the same as it actually is in pokemon, Emerald AI, learnsets, growth curve, leveling up, evolving, priority moves, natures, pokeballs, potions, recoil/siphon, flinch, confusion, status effects, sprites, typing/typechart, stat stage boosts, ev yields and exp yields)\
Pokemon Scaling by gym badge so that you get weaker pokemon early game but stranger pokemon late game (this also applies for enemy trainers, but may be scaled off your gym badges +1 or +2)\
Has mostly all pokemon and moves\
Doesnt include some s/v pokemon because pokeAPI’s showdown sprites just didn’t have them and it wasn’t worth looking for 80ish sprites\
A lot of moves are not implemented properly but if they have a base power then at least that will work, also moves only have 1 secondary effect\
### Buggy/Broken Features
The map & event spaces that were intended to hold encounters/trainers/etc\
UI that doesn’t properly handle the battles class returning null occasionally\
Learnsets for specific pokemon occasionally return null and crash the program\
The entire Emerald AI could be completely bugged and be a fluke that it was working while testing\
When evolving/knocking out an enemy pokemon, two sprites will stack over one another. This doesn’t really do anything but is kind of annoying to look at\
### Useful Resources
Processing documentation

