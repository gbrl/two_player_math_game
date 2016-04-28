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
    end
  else
    puts "Sorry, your name is too short!"
  end
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
    repl
  else
    @game_on = false 
    puts "OK! Bye!"
  end
end

def ask_question(player)
  num1 = rand(20)
  num2 = rand(20)
  answer = num1 + num2
  puts "#{player[:name]}, what is #{num1} plus #{num2}?"
  response = gets.chomp.to_i
  if response == answer
    puts "Great!"
    player[:score] += 1
  else
    puts "Wrong!"
    player[:lives] -= 1
    puts "#{player[:name]}, you have #{player[:lives]} #{player[:lives] == 1 ? 'life' : 'lives'} left."
  end
end

def repl
  puts "It's the MATH GUESSING GAME!"
  setup_players if @first_time == true
  @first_time = false
  while @game_on    
    ask_question(@p1)
    check_lives(@p1,@p2)
    ask_question(@p2)
    check_lives(@p1,@p2)
  end 
end

repl