require "colorize"
require_relative "display"

class Game
  attr_reader :guess_word, :codeword # :codeword needed for rspec

  def initialize
    @codeword = get_codeword.upcase
    @letter_positions = get_letter_positions
    @guess_word = Array.new(@codeword.length, "_")
    @correct_guesses = []
    @incorrect_guesses = []
    @display = Display.new
  end

  def play_game
    @display.start_game
    until game_over?
      @display.game_state(@incorrect_guesses, @guess_word)
      letter = get_user_guess
      check_guess(letter)
      @display.ufo(@incorrect_guesses.size) unless won?
    end
    @display.game_over(@incorrect_guesses, @guess_word, @codeword)
  end

  # Public for testing (could this be its own class to simplify testing?)
  def get_codeword
    dictionary = File.open('dictionary.txt')
    word = dictionary.readlines.sample.strip
  end

  # Public for testing
  def correct_guess?(letter)
    @codeword.include?(letter)
  end

  private 

  def get_letter_positions
    letter_positions = Hash.new { |hash, key| hash[key] = []}
    @codeword.each_char.with_index {|letter, index| letter_positions[letter] << index}
    letter_positions
  end

  def get_user_guess
    letter = prompt_user_for_guess
    until valid_guess?(letter)
      @display.invalid_guess_message if !is_alpha?(letter)
      @display.already_guessed_message if already_guessed?(letter)
      letter = prompt_user_for_guess
    end
    letter
  end

  def prompt_user_for_guess
    print "Please enter your guess: "
    gets.chomp.upcase
  end

  def valid_guess?(letter)
    is_alpha?(letter) && !already_guessed?(letter)
  end

  def is_alpha?(letter)
    ("A".."Z").include?(letter) && letter.length == 1
  end

  def already_guessed?(letter)
    @correct_guesses.include?(letter) || @incorrect_guesses.include?(letter)
  end

  def check_guess(letter)
    system("clear")
    if correct_guess?(letter)
      @correct_guesses << letter
      update_guess_word(letter)
      display_correct_guess_message
    else
      @incorrect_guesses << letter
      display_incorrect_guess_message
    end
  end

  def display_correct_guess_message
    if won?
      @display.won_message
      @display.ufo(0)
    else
      @display.correct_guess_message
    end
  end

  def display_incorrect_guess_message
    if @incorrect_guesses.size == 1
      @display.first_incorrect_guess_message
    elsif lost?
      @display.final_incorrect_guess_message
    else
      @display.random_incorrect_guess_message
    end
  end

  def update_guess_word(letter)
    @letter_positions[letter].each {|index| @guess_word[index] = letter}
  end

  def game_over?
    won? || lost?
  end

  def won?
    !@guess_word.include?("_")
  end

  def lost?
    @guess_word.include?("_") && @incorrect_guesses.size >= 6
  end

end