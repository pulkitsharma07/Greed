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
end
