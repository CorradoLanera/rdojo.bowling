
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rdojo.bowling

<!-- badges: start -->

[![R build
status](https://github.com/CorradoLanera/rdojo.bowling/workflows/R-CMD-check/badge.svg)](https://github.com/CorradoLanera/rdojo.bowling/actions)
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

## Source

The directives of the kata reported here below are taken (with very few
modification) from <https://codingdojo.org/kata/Bowling/>

## Bowling

### Problem Description

Create a program, which, given a valid sequence of rolls for one line of
American Ten-Pin Bowling, produces the total score for the game. Here
are some things that the program will not do:

  - We will not check for valid rolls.
  - We will not check for correct number of rolls and frames.
  - We will not provide scores for intermediate frames.

Depending on the application, this might or might not be a valid way to
define a complete story, but we do it here for purposes of keeping the
kata light. I think you’ll see that improvements like those above would
go in readily if they were needed for real.

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

More info on the rules at: How to Score for Bowling

### Clues

What makes this game interesting to score is the lookahead in the
scoring for strike and spare. At the time we throw a strike or spare, we
cannot calculate the frame score: we have to wait one or two frames to
find out what the bonus is.

### Suggested Test Cases

(When scoring “X” indicates a strike, “/” indicates a spare, “-”
indicates a miss)

X X X X X X X X X X X X (12 rolls: 12 strikes) = 10 frames \* 30 points
= 300

9- 9- 9- 9- 9- 9- 9- 9- 9- 9- (20 rolls: 10 pairs of 9 and miss) = 10
frames \* 9 points = 90

5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5 (21 rolls: 10 pairs of 5 and spare, with
a final 5) = 10 frames \* 15 points = 150

## Code of Conduct

Please note that the rdojo.bowling project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
