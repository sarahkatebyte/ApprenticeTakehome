require_relative "game"

system("clear")

while true
  new_game = Game.new
  new_game.play_game
  
  print "Would you like to play again (Y/N)? ".colorize(:green)
  play_again = gets.chomp.upcase
  unless play_again == "Y"
    return puts "\nThank you for playing! Goodbye!\n\n"
  end
end