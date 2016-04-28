@p1 = {name: "", score: 0, lives: 3}
@p2 = {name: "", score: 0, lives: 3}
@game_on = true
@dead_players = []
@first_time = true

def validate_name(name)
  name.length > 0 
end

def setup_players
  puts "What's your name?"
  p1_name = gets.chomp 
  if validate_name(p1_name)
    @p1[:name] = p1_name
    puts "Okay, #{@p1[:name]}, what's your opponent's name?"
    p2_name = gets.chomp
    if validate_name(p2_name)
      @p2[:name] = p2_name
      puts "Welcome, #{@p2[:name]}!"
    else
      puts "Sorry, that name is too short!"
      exit
    end
  else
    puts "Sorry, your name is too short!"
    exit
  end
end

def resurrection
  @dead_players = []
  @p2[:lives] = 3
  @p1[:lives] = 3
end

def player_dead?(player)
  player[:lives] == 0
end 

def check_lives(p1,p2)
  @dead_players << @p1[:name] if @p1[:lives] == 0
  @dead_players << @p2[:name] if @p2[:lives] == 0
  if @dead_players.length > 0
    puts "Game over, #{@dead_players[0]}, you lost! :("
    end_game?
  end
end

def end_game?
  puts "Wanna play again? (y/n)"
  response = gets.chomp
  if response == "y"
    puts "Alright! Once again..."
    resurrection
    repl
  else
    @game_on = false 
    puts "OK! #{@p1[:name]}, you scored #{@p1[:score]} points, and, #{@p2[:name]}, you scored #{@p1[:score]} points."
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
  puts "#{player[:name]}, what is #{num1} #{verb} #{num2}?"
  response = gets.chomp.to_i
  if response == answer
    puts "Great!"
    player[:score] += 1
  else
    puts "Wrong! The answer is #{answer}"
    player[:lives] -= 1
    puts "#{player[:name]}, you have #{player[:lives]} #{player[:lives] == 1 ? 'life' : 'lives'} left."
  end
end

def repl
  puts "It's the MATH GUESSING GAME!"
  setup_players if @first_time == true
  @first_time = false
  while @game_on    
    create_question(@p1)
    check_lives(@p1,@p2)
    create_question(@p2) if @game_on
    check_lives(@p1,@p2) if @game_on
  end 
end

repl