# rdojo.bowling 0.3.0


* `game()` prints the number of turns and (if it is a forfait game) the
  number of really played and the number of added `turn(0, 0)` (#4).
* `game()` stores if the number of turns is the game, if it is a
  forfait game, and the number or _really played_ turns (#4).
* `game()` return the sequences of turns, eventually added with 
  `turn(0, 0)` if some turns are missing (#4).
* `game()` can accept an arbitrary number of **turn** objects, given
  that they represent a valid (possibly forfaittary) game (#4).
* `game()` defined to store the sequence of turns in a game (#4).

# rdojo.bowling 0.2.0

* `turn()` print its output showing the overall and rolls scores, and
  the turns' type (#2).
* `turn()` stores the correct type of turns, ie standard, spare, or
  strike (#2).
* `turn()` returns overall score, and retain individual rolls' scores
   (#2).
* `turn()` can accept one or two single integer arguments (default for
  the second is 0) which individually and in sum must be included in
  [0-1] (#2).
* `turn()` defined to store turn's rolls (#2).

# rdojo.bowling 0.1.0

* Update README with project structure, usage, installation, description
  of the problem and credits.
* Providing basic development support (see `DEVELOP-SETUP.R`).

# rdojo.bowling 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
