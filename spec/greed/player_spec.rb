require_relative '../spec_helper.rb'

describe 'Player' do
  describe '#initialize' do
    before(:each) do
      @player = Greed::Player.new('Jabba')
    end

    it 'initializes the Player with a correct name' do
      expect(@player.name).to eql('Jabba')
    end

    it 'initializes the Player with 5 dice' do
      expect(@player.active.size).to eql(5)
    end

    it 'has random values in range 1..6 on each die' do
      @player.active.each do |die|
        expect(die.value).to be_between(1, 6)
      end
    end
  end

  describe '#set' do
    it 'sets the given values on the dice configuration of the Player' do
      p = Greed::Player.new('Tester')

      p.set([1, 2, 3, 4, 5])
      expect(p.active.map(&:value)).to eql([1, 2, 3, 4, 5])

      p.set([4, 3])
      expect(p.active.map(&:value)).to eql([4, 3])

      p.set([2, 2, 4])
      expect(p.active.map(&:value)).to eql([2, 2, 4])
    end
  end

  describe '#reset' do
    it 'should provide the player with fresh new dice' do
      p = Greed::Player.new('1')

      p.set([2, 3, 4])

      p.reset
      expect(p.active.size).to eql(5)
    end
  end

  describe '#lost_turn' do
    before(:each) do
      @player = Greed::Player.new(1)
    end

    it 'should subtract the round_score from the total_score' do
      @player.total_score = 400
      @player.lost_turn(100)
      expect(@player.total_score).to eql(300)
    end

    it 'should not make total_score be negative' do
      @player.total_score = 300
      @player.lost_turn(400)
      expect(@player.total_score).to eql(0)
    end
  end
end
