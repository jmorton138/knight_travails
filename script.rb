require './lib/main.rb'

puts "Enter starting x coordinate"
x1 = gets.chomp.to_i
while x1 > 7 || x1 < 0
    puts "Please enter a value between 0 and 7 inclusive"
    x1 = gets.chomp.to_i
end
puts "Enter starting y coordinate"
y1 = gets.chomp.to_i
while y1 > 7 || y1 < 0
    puts "Please enter a value between 0 and 7 inclusive"
    y1 = gets.chomp.to_i
end
a = [x1, y1]

puts "Enter ending x coordinate"
x2 = gets.chomp.to_i
while x2 > 7 || x2 < 0
    puts "Please enter a value between 0 and 7 inclusive"
    x2 = gets.chomp.to_i
end
puts "Enter ending y coordinate"
y2 = gets.chomp.to_i
while y2 > 7 || y2 < 0
    puts "Please enter a value between 0 and 7 inclusive"
    y2 = gets.chomp.to_i
end
b = [x2, y2]
knight_moves(a, b)