require_relative '../spec_helper.rb'

describe 'Die' do
  describe '#initialize' do
    it 'should initialize the die correctly' do
      d = Greed::Die.new(2)
      expect(d.value).to eql(2)
    end

    it 'should initialize die to a random number if no parameter is given' do
      d = Greed::Die.new
      expect(d.value).to be_between(1, 6)
    end
  end
end
