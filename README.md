# Knight Travails

## About this project
Command line Ruby program that calculates the shortest possible path/number of moves it takes a knight to get from position A to position B on the chessboard.

This was done as the Knight Travails project in The Odin Project's Full Stack Ruby on Rails Curriculum. See the full assignment specifications here: https://www.theodinproject.com/paths/full-stack-ruby-on-rails/courses/ruby-programming/lessons/knights-travails.

A knight in chess can only move in an L-shape– 2 spaces in one direction and 1 space in a perpendicular direction. Using these constraints, this program determines the smallest number of moves to get to any given point on the chess board and lists out the exact moves to get there.

To do this I used breadth first traversal of a graph data structure because each node had 8 children/moves (unless some of those children were out of bounds of the gameboard).

## Get started

Clone the repo to your local machine:

`$ git clone https://github.com/jmorton138/knight_travails`

Navigate into the projects directory and run the project from the terminal:

`ruby lib/main.rb`


