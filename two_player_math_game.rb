p1 = {name: "", score: 0, }
p2 = ""

def repl
  puts "It's the MATH GUESSING GAME!"
  keep_going = true
  while keep_going
    puts "What's your name?"
    p1[:name] = gets.chomp

    response = gets.chomp.downcase
    if response
    else
      puts "Sorry, we didn't understand your command."
    end
  end  
end

repl