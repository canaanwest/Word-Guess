require "pry"
require "colorize"

class ASCII_display
  attr_reader :ASCII_init, :displayed, :turns
  def initialize
    @ASCII_init = ["  @ . . @".colorize(:green), "  ( --- )".colorize(:green), " (  >__<  )".colorize(:green), " ^^  ~~  ^^".colorize(:green), " ~~~~~~~~~~~".colorize(:green), "  ~~~~~~~~~".colorize(:green)]
    @turns = @ASCII_init.length
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
  attr_reader :word, :word_bank, :word_array, :letters, :attempts, :picture, :update_letters
  def initialize
    @word_bank= ["hello", "word"]
    @word= @word_bank.sample
    @word_array = @word.split("")
    @letters = put_spaces(@word)
    @attempts= []
    @picture = ASCII_display.new #SOME ASCII art as an arg
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
    puts @picture.displayed
    puts "#{@letters}\n\n"
    puts "You've guessed: #{@attempts} \n"

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
      puts "\nYOU LOSE. #{@word} was the word."
      exit
    else
      # user_guesses
      puts "keep going! \n\n"
    end
  end

  #WORKS!
  def guessed_word(guess)
    if guess == @word
      puts "You win!"
      exit
    end
  end



  def update_picture
    return @picture.update_ASCII_display
  end

end



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
game1 = Game.new

def user_guesses(game)
  # puts game.letters
  puts "Pick a letter!!"
  guess = gets.chomp.downcase
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


def check(game, guess) ### check for when user inputs same letter
  game.update_letters(guess) # method that we will define later
end

def win?(game)
  game.letters.split(" ").join("") == game.word
end




#INTERFACE!!!!
puts game1.letters

until win?(game1)
  check(game1, user_guesses(game1))
end

puts "You won!!! The word was #{game1.word}\n"

##Figure out where the letters are being displayed each time within the code--we want it to display below the picture
##Figure out if there's a way to change the color
