require "./lib/chess.rb"

puts "load previous game? y/n\n"
if gets.chomp == "y"
  g = Storage.new.load_game
else
  g = Game.new
end
g.start

