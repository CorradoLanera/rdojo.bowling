
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rdojo.bowling

<!-- badges: start -->

[![R build
status](https://github.com/CorradoLanera/rdojo.bowling/workflows/R-CMD-check/badge.svg)](https://github.com/CorradoLanera/rdojo.bowling/actions)
[![Codecov test
coverage](https://codecov.io/gh/CorradoLanera/rdojo.bowling/branch/master/graph/badge.svg)](https://codecov.io/gh/CorradoLanera/rdojo.bowling?branch=master)
[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://www.tidyverse.org/lifecycle/#maturing)
[![CRAN
status](https://www.r-pkg.org/badges/version/rdojo.bowling)](https://CRAN.R-project.org/package=rdojo.bowling)
<!-- badges: end -->

The goal of rdojo.bowling is to implements and documents the bowling
kata for the TDD dojo in R step-by-step.

## Installation

You can install the development version of `{rdojo.bowling}` from
[GitHub](https://github.com) with:

``` r
# install.packages("remotes")
remotes::install_github("CorradoLanera/rdojo.bowling")
```

## Bowling

### Problem Description

> Create a program, which, given a sequence of rolls for one line of
> American Ten-Pin Bowling, produces the total score for the game.

Here a thing that the program will not do:

  - We will not provide scores for intermediate frames, ie every game
    will be considered completed (eventually with rolls of 0 score). In
    other words, whenever we will ask for a score, we will consider the
    game like a new one.

We can briefly summarize the scoring for this form of bowling:

1.  Each game, or “line” of bowling, includes ten turns, or “frames” for
    the bowler.

2.  In each frame, the bowler gets up to two tries to knock down all the
    pins.

3.  If in two tries, he fails to knock them all down, his score for that
    frame is the total number of pins knocked down in his two tries.

4.  If in two tries he knocks them all down, this is called a “spare”
    and his score for the frame is ten plus the number of pins knocked
    down on his next throw (in his next turn).

5.  If on his first try in the frame he knocks down all the pins, this
    is called a “strike”. His turn is over, and his score for the frame
    is ten plus the simple total of the pins knocked down in his next
    two rolls.

6.  If he gets a spare or strike in the last (tenth) frame, the bowler
    gets to throw one or two more bonus balls, respectively. These bonus
    throws are taken as part of the same turn. If the bonus throws knock
    down all the pins, the process does not repeat: the bonus throws are
    only used to calculate the score of the final frame.

7.  The game score is the total of all frame scores.

### Clues

What makes this game interesting to score is the lookahead in the
scoring for strike and spare. At the time we throw a strike or spare, we
cannot calculate the frame score: we have to wait one or two frames to
find out what the bonus is.

## Environment setup

I use RStudio as IDE, `{testthat}` for development-time tests and
`{assertive}` for run-time tests.

All the development is continuously monitored by the
`testthat::auto_test_package()` function (run continuously as a
background RStudio job thanks to the
[`{autotestthat}`](https://github.com/CorradoLanera/autotestthat/)
package)

## Development strategy

The package (master branch) will implement the final solution. Here I
report step-by-step the development process, which would be reflected in
the commit history and structure.

The development will be organized as follow: 0. Definition of the
*acceptance tests* (reported here below and in the first issue).

1.  every macro task/requirements is reported in a issue

2.  on a issue-dedicated feature branch the TDD cycle will be
    implemented with at least three (two if refactor is not needed)
    commits:

<!-- end list -->

1.  **test fails**: including aims/feature required
2.  **test pass**: including code implementation
3.  **refactor**: including both code and test refactoring

<!-- end list -->

3.  repeat 2 a-c until the macro task is satisfied

4.  once all the tests pass, the feature-branch will be pull-requested
    on the development one and increment the minor version number

5.  repeat 1-4 until the problem is solved (ie satisfactory test passed)

6.  pull request on the master branch and increment major version
    number.

## Step-by-step solution

### Definition of *done*

For the purpose of this kata, the definition of *done* is the complete
satisfaction of the following requirements.

  - (When scoring “X” indicates a strike, “/” indicates a spare, “-”
    indicates a miss)

  - X X X X X X X X X X X X (12 rolls: 12 strikes) = 10 frames \* 30
    points = 300

  - 9- 9- 9- 9- 9- 9- 9- 9- 9- 9- (20 rolls: 10 pairs of 9 and miss) =
    10 frames \* 9 points = 90

  - 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5 (21 rolls: 10 pairs of 5 and spare,
    with a final 5) = 10 frames \* 15 points = 150

  - check for valid rolls (negative, fractional, or more than 10 points
    in a roll or in a turn will lead to an error)

  - check for correct number of rolls and frames (if more then the
    admitted it will lead to an error, of less then the necessary for a
    full game it will lead to a warning completing the game with 0s
    points each rolls, ie it is considered a *forfeit*)

  - 5/ 5- (4 rolls: a 5 and a spare, a 5 and a miss) = 2 frames with 15
    + 5 points = 20 points

  - X X X X X X X X X 5/ X X (12 rolls: 9 strikes, one 5 and a spare, 2
    strikes) = 8 frames \* 30 points + 2 frame \* 20 points + extra
    frame = too much frames\! –\> error

  - 5/ 5 (3 rolls: a 5 and a spare, a 5) = 1 frame + 1 not complete
    frame with 15 + 5 (+ 0s and a single warn for all the missing rolls)
    points = 20 points

The requirements still in natural language until the program and its
function names and API are defined. Next, each one must be connected to
a corresponding formal test.

## Credits

The directives of the kata used here are adapted from the ones in
<https://codingdojo.org/kata/Bowling/>

## Code of Conduct

Please note that the rdojo.bowling project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
