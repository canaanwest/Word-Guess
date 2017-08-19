require "pry"
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
  attr_reader :word_array, :letters, :attempts, :picture, :update_letters, :category
  attr_accessor :word

  def initialize

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

  def update_letters(guess)
    if guess.length > 1
      guessed_word(guess)
    end
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

    # return @letters
    update_attempts(guess)
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

  #WORKS
  def update_attempts(guess)
    @attempts.push(guess)
    if @picture.ASCII_init.length == 0 #we can change default later
      puts "\nYOU LOSE.".red.blink + " #{@word} was the word.".red
      exit
    else
      # user_guesses
      puts "keep going! \n\n"
    end
  end

  #WORKS!
  def guessed_word(guess)
    if guess == @word
      puts "YOU WIN!!".green.blink
      exit
    end
  end
end #END game class

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
  # puts game.letters
  puts "Pick a letter, dash, or apostrophe."
  guess = gets.chomp.downcase
  guess = valid_guess(guess, game)
  return guess
end

def check(game, guess)
  game.update_letters(guess)
end

def win?(game)
  game.letters.split(" ").join("") == game.word
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
until win?(game1)
  check(game1, user_guesses(game1))
end

puts "You won!!! The word was #{game1.word}\n".green.blink

##Figure out where the letters are being displayed each time within the code--we want it to display below the picture
##Figure out if there's a way to change the color


# game1 = Game.new
# puts game1.letters
# puts game1.update_letters("o")
# puts game1.update_letters("z")
# puts game1.update_letters("l")
# puts game1.update_letters("a")
# puts "#{game1.attempts}"
# puts game1.update_picture
# puts game1.update_picture




#
#
# #~~~~~~~~~~
#
