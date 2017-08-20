require "colorize"
require "faker"

class ASCII_display
  attr_reader :ASCII_init, :displayed
  def initialize
    @ASCII_init = ["  @ . . @".green, "  ( --- )".green, " (  >__<  )".green, " ^^  ~~  ^^".green, " ~~~~~~~~~~~".green, "  ~~~~~~~~~".green]
    @displayed = display_picture(@ASCII_init)
    #store picture as an array
  end

  def display_picture(picture)
    picture.each do |line|
      puts "#{line} \n"
    end
  end

  def update_ASCII_display
    return @ASCII_init.delete(@ASCII_init[-1])
  end
end #End of ASCII_display class

class Game
  attr_reader :word_array, :status, :letters, :attempts, :picture, :right_or_wrong_guess, :category
  attr_accessor :word

  def initialize
    @status = "in progress"
    @category= {"color" => Faker::Color.color_name, "dessert" => Faker::Dessert.variety, "family guy" => Faker::FamilyGuy.character, "hipster" => Faker::Hipster.word}#want to use faker for this
    @word= ""
    @attempts= []
    @picture = ASCII_display.new #SOME ASCII art as an arg
  end

  def make_word_array
    @word.slice!(" ")
    @word_array = @word.split("")
    @letters = put_spaces(@word)
  end

  def show_display
    puts @picture.displayed
    puts "#{@letters}\n\n"
    puts "You've guessed: #{@attempts} \n"
  end

  def status_update(guess)
    @attempts.push(guess)
    if @letters.split(" ").join("") == @word || guess == @word
      @status = "win"
    elsif @picture.ASCII_init.length == 0 #we can change default later
      @status = "lose"
    else
      @status = "in progress"
    end
    return @status
  end

  def right_or_wrong_guess(guess)
    flag = false
    @word_array.each_index do |index|
      if @word_array[index] == guess
        @letters[index*2] = guess
        flag = true
        puts "\n\nGood job! You got one!"
      end
    end
    if flag == false
      puts "\nYou guessed wrong, sucker!"
      @picture.update_ASCII_display
    end

    status_update(guess)
    puts "\e[H\e[2J"
    show_display
  end

  private
  def put_spaces(word)
    spaces = []
    word.length.times do |space|
      spaces.push("_")
    end
    return spaces.join(" ")
  end
end

#USER
def valid_guess(guess, game)
  while guess == guess.to_i.to_s
    puts "Please enter a letter or a word."
    guess = gets.chomp.downcase
  end
  while game.attempts.include?(guess)
    puts "You already guessed that! Try again!"
    guess = gets.chomp.downcase
  end
  return guess
end

def user_guesses(game)
  puts "Pick a letter, dash, or apostrophe."
  guess = gets.chomp.downcase
  guess = valid_guess(guess, game)
  return guess
end

def check(game, guess)
  game.right_or_wrong_guess(guess)
end

def game_over?(status, game)
  over = false
  if status == "win"
    puts "YOU WIN!".green.blink
    over = true
  elsif status == "lose"
    puts "YOU LOSE!".red.blink + "The word was #{game.word}"
    over = true
  end
  return over
end

#INTERFACE!!!!
game1 = Game.new

puts "Welcome to Word Guess! Your category choices are: \n"
puts game1.category.keys

puts "\nWhich category would you like?"
user_category = gets.chomp.downcase
puts "\e[H\e[2J"
game1.word = game1.category[user_category].downcase
game1.make_word_array
game1.show_display

until game_over?(game1.status, game1)
  check(game1, user_guesses(game1))
end
