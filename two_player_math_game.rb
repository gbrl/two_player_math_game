class Player
  attr_accessor :name, :score, :lives

  def initialize(name,score=0,lives=3)
    @name = name
    @score = score
    @lives = lives
  end

  def resurrect
    self.lives = 3
  end

  def dead?
    self.lives == 0
  end 

  def score_point
    self.score += 1
  end

  def lose_a_life
    self.lives -= 1
  end
end

@game_on = true
@first_time = true

def validate_name(name)
  name.length > 0 
end

def setup_players
  puts "What's your name?"
  p1_name = gets.chomp 
  if validate_name(p1_name)
    @p1 = Player.new(p1_name)
    puts "Okay, #{@p1.name}, what's your opponent's name?"
    p2_name = gets.chomp
    if validate_name(p2_name)
      @p2 = Player.new(p2_name)
      puts "Welcome, #{@p2.name}!"
    else
      puts "Sorry, that name is too short!"
      exit
    end
  else
    puts "Sorry, your name is too short!"
    exit
  end
end

def resurrection(*players)
  players.each {|p| p.resurrect } 
end


def check_lives(player)
  if player.dead?
    puts "Game over, #{player.name}, you lost! :("
    play_again?
  end
end

def play_again?
  puts "Wanna play again? (y/n)"
  response = gets.chomp
  if response == "y"
    puts "Alright! Once again..."
    resurrection(@p1,@p2)
    repl
  else
    @game_on = false 
    puts "OK! #{@p1.name}, you scored #{@p1.score} points, and, #{@p2.name}, you scored #{@p2.score} points."
  end
end

def create_question(player)
  question_type = rand(3)
  # 0 == Addition, 1 == Subtraction, 2 == Multiplication, 
  case(question_type)
  when(0)
    num1 = rand(30)
    num2 = rand(30)
    answer = num1 + num2
    type = "plus"
  when(1)
    num1 = rand(20)
    num2 = rand(20)
    answer = num1 - num2
    type = "minus"
  when(2)
    num1 = rand(10)
    num2 = rand(10)
    answer = num1 * num2
    type = "times"
  else
    exit
  end
  ask_question(player,num1,num2,answer,type)
end

def ask_question(player,num1,num2,answer,verb)
  puts "#{player.name}, what is #{num1} #{verb} #{num2}?"
  response = gets.chomp.to_i
  if response == answer
    puts "Great!"
    player.score_point
  else
    puts "Wrong! The answer is #{answer}"
    player.lose_a_life
    puts "#{player.name}, you have #{player.lives} #{player.lives == 1 ? 'life' : 'lives'} left."
  end
end

def repl
  puts "It's the MATH GUESSING GAME!"
  setup_players if @first_time == true
  @first_time = false
  while @game_on    
    [@p1,@p2].each do |player|
      if @game_on
         create_question(player)
         check_lives(player)
      end
    end
  end 
end

repl