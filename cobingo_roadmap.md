Developing CoBingo:

- Create new board
- get board
- add player
- [client] sync boards between clients
- mark/unmark cells


Events:
- create_board
- add_player
- remove_player
- mark_cell
- unmark_cell


State:
```
  {
    "board": {
      // Unique identifier for this board
      "id": "AFo1af12",
      // Seed used for random number generation to create this board
      "seed": "seed data",
      // Single dimensional size of the board
      "size": 5,
      // Total number of cells on the board (size^2)
      "cell_count": 25,
      // List of all cells on the board
      "cells": [
        {
          // Name to be displayed in the cell.
          "goal": "Some Objective",
          // Additional information about the objective.
          "clarification": "Duping is not allowed",
          // Difficulty level of the goal (0..25 in most cases)
          "difficulty": 13,
          // Synergetic types of the cell. Used to avoid generating boards with shared goals.
          "types": ["type1", "type2"],
          // List of players that have marked the goal.
          "marked_by": ["player1"]
        }
      ]
    }
  }
```
