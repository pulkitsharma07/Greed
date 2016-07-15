require_relative 'lib/greed.rb'

def roll
  dice = $current_player.roll
  print "Player #{$current_player.name}".green + " rolls: "
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

def ask
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
  print "\nTurn #{turn}".yellow + "\n" + '_' * 10 + "\n"
end

print 'Enter number of players: '

num_players = gets.chomp.to_i

players = []

num_players.times do |player_name|
  players << Greed::Player.new((player_name + 1).to_s)
end

current_player_index = 0
turn = 1
same_player = false
new_turn = true
round_total_score = 0
final_round = false
final_player = -1

loop do

  if current_player_index == final_player
    current_player_index = current_player_index + 1

    if current_player_index == players.size
      # last player
      break
    else
      # more players left
      next
    end
  end
  $current_player = players[current_player_index]
  banner(turn) if new_turn
  new_turn = false

  roll
  show_score

  round_total_score += $current_player.round_score

  $current_player.lost_turn(round_total_score) if $current_player.round_score == 0

  show_total_score

  if $current_player.state == 'final'
    final_round = true
    final_player = current_player_index
  end

  same_player = (ask if !$current_player.active.empty? && $current_player.round_score != 0)

  unless same_player

    $current_player.reset

    current_player_index += 1
    if current_player_index == players.size

      break if turn == 'FINAL ROUND'

      turn += 1
      new_turn = true
      current_player_index = 0

      turn = 'FINAL ROUND' if final_round

    end
    round_total_score = 0
  end

  print "\n\n"

end
