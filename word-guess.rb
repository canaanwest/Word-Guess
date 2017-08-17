require "pry"

class ASCII_display
  attr_reader :ASCII_init, :displayed
  def initialize
    @ASCII_init = ["///", "////", "/////"]
    @displayed = display_picture(@ASCII_init)
    #store picture as an array
  end

  def display_picture(picture)
    picture.each do |line|
      puts "#{line} \n"
    end
  end

  def update_ASCII_display
    @ASCII_init.delete(@ASCII_init[0])
    return display_picture(@ASCII_init)
  end
end #End of ASCII_display class



class Game
  attr_reader :word, :word_bank, :word_array, :letters, :bad_attempts, :picture, :update_letters
  def initialize
    @word_bank= ["hello", "word"]
    @word= @word_bank.sample
    @word_array = @word.split("")
    @letters = put_spaces(@word)
    @bad_attempts= []
    @picture = ASCII_display.new #SOME ASCII art as an arg
  end

#works!
  def put_spaces(word)
    spaces = []
    word.length.times do |space|
      spaces.push("_")
    end
    return spaces.join(" ")
  end


#will only excute when guess is correct
#WORKS!
  def update_letters(guess)
    @word_array.each_index do |index|
      if @word_array[index] == guess
        @letters[index*2] = guess
      end
    end
    return @letters
  end



  def update_picture
    return @picture.update_ASCII_display
  end

end



game1 = Game.new
puts game1.letters
puts game1.update_letters("o")
puts game1.update_picture
puts game1.update_picture



#puts game1.picture.update_ASCII_display

#
#
#   def update_bad_attempts(guess)
#     @bad_attempts.push(guess)
#
#     if @bad_attempts.length == 6 #we can change default later
#       puts "You LOSE. #{@word} was the word."
#       exit
#     else
#       user_guesses
#     end
#   end
#
#
# end
#
#
#
#



#
#
# #~~~~~~~~~~
#
# game1 = Game.new
#
# def user_guesses
#   puts "Pick a letter!!"
#   guess = gets.chomp.downcase
#   return guess
# end
#
#
# def check(guess)
#   if game1.word.include?(guess) # does it need to be able to read the word?
#     game1.update_letters # method that we will define later
#   else
#     game1.update_picture
#     game1.update_bad_attempts # method we will define later
#   end
# end
#
#
# check(user_guesses)
