# Module to handle all the game functionality
module Greed
  RULES = {}

  6.times do |x|
    RULES[x + 1] = []
  end

  RULES[1] << [3, 1000] << [1, 100]
  RULES[2] << [3, 200]
  RULES[3] << [3, 300]
  RULES[4] << [3, 400]
  RULES[5] << [3, 500] << [1, 50]
  RULES[6] << [3, 600]

  # Class to handle Die
  class Die
    attr_accessor :value

    def initialize
      roll
    end

    def roll
      @value = rand(1..6)
    end

    def to_s
      @value
    end
  end

  # Class to handle the Player
  class Player
    attr_reader :active, :name, :total_score, :state, :round_score

    def initialize(name)
      @name = name
      @total_score = 0
      @state = 'init'
      @active = []
      5.times do
        @active << Die.new
      end

       # @active[0].value = 1
       # @active[1].value = 6
       # @active[2].value = 6
       # @active[3].value = 6
       # @active[4].value = 5

    end

    def roll
      @active.map(&:roll)
    end

    def calc_score
      # p @active.map(&:to_s).join(', ')
      @round_score = used = 0

      self.class.frequencies(@active.map(&:value)).each do |elem|
        points = self.class.points(elem[0], elem[1])
        used += points[1]
        @round_score += points[0]
      end

      @active = @active[0...-used] if used != 0 && used != 5

      @state = 'accumulate' if round_score > 300
      @state = 'final' if @total_score >= 3000

      @total_score += @round_score if @state == 'accumulate'

      @round_score
    end

    def reset
      new_active = []
      5.times do
        new_active << Die.new
      end
      @active.replace(new_active)
    end

    def lost_turn(round_score)
      @total_score -= round_score
      @total_score = [0, @total_score].max
    end

    def self.test(input)
      tot = 0
      frequencies(input).each do |elem|
        points = points(elem[0], elem[1])
        tot += points
      end
      p tot
    end

    def self.points(value, times)
      points = 0
      freq = times
      dice_used = 0

      loop do
        curr_iteration_score = 0

        RULES[value].each do |rule|

          if rule[0] <= times
            curr_iteration_score += rule[1]
            print "Using #{rule[0]} times\n"
            dice_used += rule[0]
            times -= rule[0]
            break
          end
        end

        points += curr_iteration_score
        break if curr_iteration_score == 0
      end

      [points, dice_used]
    end

    def self.frequencies(dice)
      counts = {}
      dice.each do |die|
        counts[die] = (counts[die] || 0) + 1
      end

      counts
    end
  end
end
