require_relative 'greed.rb'

def roll
  dice = $current_player.roll
  print "Player #{$current_player.name} rolls: "
  puts dice.join(', ')
end

def show_score
  print 'Score in this round: '
  score = $current_player.calc_score
  puts score
  score
end

def show_total_score
  print 'Total score: '
  puts $current_player.total_score
end

def ask_again
  print 'Do you want to roll the non-scoring '\
        "#{$current_player.active.size} dices?(y/n): "
  response = gets.chomp
  if response.start_with?('y')
    true
  else
    false
  end
end


def banner(turn)
  print "\nTurn #{turn}\n" + "_"*10 + "\n"
end

players = []
players << Greed::Player.new('1')
players << Greed::Player.new('2')


current_player_index = 0
turn = 1
same_player = false
new_turn = true
round_total_score = 0

loop do
  $current_player = players[current_player_index]

  banner(turn) if new_turn
  new_turn = false


  roll
  show_score

  round_total_score += $current_player.round_score

  $current_player.lost_turn(round_total_score) if $current_player.round_score == 0


  show_total_score

  same_player = (ask_again if !$current_player.active.empty? && $current_player.round_score != 0)

  unless same_player

    $current_player.reset

    current_player_index += 1
    if(current_player_index == players.size)
      turn += 1
      new_turn = true
      current_player_index = 0
    end
    round_total_score = 0
  end

  print "\n\n"

end
