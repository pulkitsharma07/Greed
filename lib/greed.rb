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

  def self.points(value, times)
    points = 0
    freq = times
    dice_used = 0

    loop do
      curr_iteration_score = 0

      RULES[value].each do |rule|
        if rule[0] <= times
          curr_iteration_score += rule[1]
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

  def self.test(input)
    tot = 0
    used = 0
    Greed.frequencies(input).each do |elem|
      points = Greed.points(elem[0], elem[1])
      tot += points[0]
      used += points[1]
    end
    [tot, used]
  end
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

      Greed.frequencies(@active.map(&:value)).each do |elem|
        points = Greed.points(elem[0], elem[1])
        used += points[1]
        @round_score += points[0]
      end

      # All die are scoring
      if used == @active.size
        reset
        used = 0
      end

      @active = @active[0...-used] if used != 0

      @state = 'accumulate' if round_score >= 300

      @total_score += @round_score if @state == 'accumulate'
      @state = 'final' if @total_score >= 3000

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
  end
end

#Adding some methods to colorize
class String
  # colorization
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def light_blue
    colorize(36)
  end
end
