
<img src="https://github.com/PeterMyrobot/Slide-Puzzle-Game-on-Swift/blob/master/13632691_1276837922328184_712747428_o.gif" width="300">

# Slide-Puzzle-Game-on-Swift
Build a slide puzzle game on swift2 and Xcode version 7.3

I'm doing the fundation of programming, and following the class CS50 on youtube, saw this game as an assignment,
so I decided to bulid my own slide puzzle game on Swift.

#In this App, I learned how to use

UISwipeGestureRecognizer: Let app can know what direction user want to move.
  
NSTimer: Can counting the time that user spend to solve the puzzle.

AlertController: To tell user they solve this problem, and allows them to restart the game.

Arc4random_uniform: To create a random array as a problem.

#About the problem is solvable or not

I found a web site discuss with this quition, https://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html

The formula says:

If the grid width is odd, then the number of inversions in a solvable situation is even.

If the grid width is even, and the blank is on an even row counting from the bottom (second-last, fourth-last etc), then the number of inversions in a solvable situation is odd.

If the grid width is even, and the blank is on an odd row counting from the bottom (last, third-last, fifth-last etc) then the number of inversions in a solvable situation is even.

So I use the formula above to check the random array I generate is solvable or not.
