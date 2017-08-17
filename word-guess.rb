class Game

  def initialize
    @word_bank= []
    @word= word_bank.sample
    @spaces= @word.length
    @bad_attempts= []
    @picture
  end

  def update_display
    #replace a blank with a letter
    #check indexes
  end

  def update_picture
    #will call this on @display when the user incorrectly guesses letter
  end

  def check(guess)
    if @word.include?(guess)
      update_display # method that we will define later
    else
      update_picture
      update_attempts # method we will define later
  end


  def update_attempts(guess)
    @bad_attempts.push(guess)

    if @bad_attempts.length == 6 #we can change default later
      puts "You LOSE. #{@word} was the word."
    end
  end


end
