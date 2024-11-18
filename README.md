Faux Hollows solver based on [the popular web tool](https://sturalke.github.io/FauxHollowsProbabilisticSolver/) by Fyrin Niyuun @ Behemoth but with revised recommendation logic.
The aforementioned tool considers all conceivably possible board patterns however it has been observed that not all such patterns can be generated by the game. All reported patterns have been catalogued by u/Ylandah into [a google spreadsheet](https://docs.google.com/spreadsheets/d/e/2PACX-1vT_86iXUmlPcdn6Eimh2QqSEe1mBy5PJCjutOaQPZJpPeiLnYkG1WVApuEgj-HhZzWuKHr4fKTBL1O2/pubhtml#) and will be assumed to be an exhaustive list.
The logic used in this tool is inspired by 3Blue1Brown video [Solving Wordle using information theory](https://youtu.be/v68zYyaEmEA?si=XqW2KUYzIUFwCwD1).

[Click here to download the installer](https://github.com/sinjidk/ffauxivsolver/raw/refs/heads/main/ffauxivsolverapp/for_redistribution/ffauxivsolverInstaller_web.exe). Note that the tool is currently developed in Matlab and as such it requires you also install the Matlab Runtime Environment (the installer will prompt to do this for you).

__How to Use__

Top row buttons:
- Visual toggle between coffer or gift, may in the future affect recommendations.
- Reset the grid to begin a new game of Faux Hollows.
- Visual toggle between tell or retell, may in the futur affect recommendations.
- Undo most recent grid selection.

Bottom row buttons:
- Select which type of tile you wish to place or search for.
- Will automatically change selection when all squares of type have been identified.
- "Selected" text appears above the current selection.

Grid buttons:
- Selecting a grid button will mark the square as selected in the bottom row.
- Grid tiles that are possible to be the type of tile currently selected in the bottom row will be highlighted with a faded version of their colour.
- Based on this information, any grid tiles with only one possible outcome will automatically appear.
- Tiles highlighted in black with a white question mark (❔) are the recommended tile(s) to reveal on your board in-game if you explicitely want to find the type of tile currently selected in the bottom row.
- Tiles highlighted in white with a white question mark (❔) are the overall recommended tile(s) to reveal on your board in-game (if different from the above black tile).

Steps ([adapted from u/Lyramion](https://www.reddit.com/r/ffxiv/comments/10qd2qc/how_to_efficiently_use_the_faux_hollow_solver/)):
1. Select blocked tiles present on your in-game board until all 5 have been automatically determined and swords becomes selected.
2. Note if any tiles are highlighted white in the tool, if so, reveal one on your in-game board, otherwise reveal a black-highlighted tile instead.
3. Mark in the tool which type of tile was just revealed in-game and, if it was a sword or box revealed, complete the shape in the tool.

Proceed depending on whether this is your first or second board of the week.

Tell (first board of the week):
1. Continue revealing black-highlighted tiles and marking the information in the tool until sword is found and completed.
2. If the box has not yet been located and at least 4 turns remain, select it in the bottom row and continue revealing black-highlighted tiles and marking the information in the tool until the box is found or less than 4 turns remain.
3. If the box was found with sufficient turns remaining to complete it then do so and then search for fox with remaining turn (if any), otherwise spend all remaining turns searching for fox.

Retell (second board of the week):
1. Continue revealing white- or black-highlighted tiles and marking the information in the tool until any non-blank tile is found **but do not complete it in-game**.
2. If the box has not yet been located and at least 4 turns remain, select it in the bottom row and continue revealing black-highlighted tiles and marking the information in the tool until the box is found or less than 4 turns remain.
3. If the box was found with sufficient turns remaining to complete it then do so and then search for fox with remaining turn (if any), otherwise spend all remaining turns searching for fox.
4. If you were lucky enough to complete the box and fox with sufficient turns remaining to complete the sword then do so, otherwise idk vibe i guess.
