require './lib/main.rb'
puts "******Knight Moves Calculator******"
puts "This program returns the number of minimal number of moves it takes a knight chess piece to move from point a to point b, as well as printing out the actual path itself."
puts ""
puts "This program assumes an 8x8 chessboard. Coordinates range from 0 to 7. So [0, 0] represents the lower left hand corner space on the board."
puts ""
puts "Any non-numerical value entered is treated as a '0'."
puts ""
puts "To use this program, simply follow the prompts, entering in your desired coordinates."
puts ""
puts "Let's begin"
puts ""
puts "Enter starting x coordinate:"
x1 = gets.chomp.to_i
while x1 > 7 || x1 < 0
    puts "Please enter an integer between 0 and 7 inclusive"
    x1 = gets.chomp.to_i
end

puts "Enter starting y coordinate:"
y1 = gets.chomp.to_i
while y1 > 7 || y1 < 0
    puts "Please enter an integer between 0 and 7 inclusive"
    y1 = gets.chomp.to_i
end

a = [x1, y1]

puts "Enter ending x coordinate:"
x2 = gets.chomp.to_i
while x2 > 7 || x2 < 0
    puts "Please enter an integer between 0 and 7 inclusive"
    x2 = gets.chomp.to_i
end

puts "Enter ending y coordinate:"
y2 = gets.chomp.to_i
while y2 > 7 || y2 < 0
    puts "Please enter an integer between 0 and 7 inclusive"
    y2 = gets.chomp.to_i
end

b = [x2, y2]

knight_moves(a, b)