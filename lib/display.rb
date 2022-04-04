require_relative "ufo"

class Display
  include UFO

  RANDOM_INCORRECT_MESSAGES = ["That's okay, I would have guessed that too.", "You'll get the next letter. You got this!", "Don't give up; you'll get there!", "If at first you don't succeed, try, try again!"]

  FINAL_INCORRECT_MESSAGES = ["Oh no! The aliens have captured another one!", "Oh no! The person has been abducted. Better luck next time!"]

  def start_game
    system("clear")
    puts "UFO: The Game".colorize(:blue)
    puts "Instructions: save us from alien abduction by guessing letters in the codeword.".colorize(:blue)
    ufo(0)
  end

  def game_state(incorrect_guesses, guess_word)
    puts "\nIncorrect Guesses:"
    puts display_incorrect_guesses(incorrect_guesses)
    puts guess_word(guess_word)
  end

  def ufo(index)
    puts UFO[index].colorize(:green)
  end

  def display_incorrect_guesses(incorrect_guesses)
    if incorrect_guesses.empty?
      puts "None"
    else
      incorrect_guesses.each {|letter| print letter + " "}
      puts
    end
  end
  
  def guess_word(guess_word)
    print "Codeword: "
    guess_word.each {|char| print char + " "}
    puts
  end

  def invalid_guess_message
    puts "\nI cannot understand your input. Please guess a single letter.\n".colorize(:red)
  end

  def already_guessed_message
    puts "\nYou can only guess that letter once, please try again.\n".colorize(:red)
  end

  def won_message
    puts "CONGRATULATIONS! You saved the person and earned a medal of honor!".colorize(:blue)
  end

  def correct_guess_message
    puts "Correct! You're closer to cracking the codeword.".colorize(:blue)
  end

  def first_incorrect_guess_message
    puts "Whoops! The tractor beam pulls the person in further!".colorize(:red)
  end

  def random_incorrect_guess_message
    puts RANDOM_INCORRECT_MESSAGES.sample.colorize(:red)
  end

  def final_incorrect_guess_message
    puts FINAL_INCORRECT_MESSAGES.sample.colorize(:red)
    puts
  end

  def game_over(incorrect_guesses, guess_word, codeword)
    game_state(incorrect_guesses, guess_word)
    puts "The codeword is: #{codeword}\n\n"
  end

end