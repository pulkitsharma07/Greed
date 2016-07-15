require_relative '../spec_helper.rb'

describe 'Greed' do
  describe '.points' do
    context 'direct rules' do
      # .points returns [a,b]
      #   a : points
      #   b : the number of die used

      it 'should give 1000: for 3 times 1' do
        expect(Greed.points(1, 3)[0]).to eql(1000)
        expect(Greed.points(1, 3)[1]).to eql(3)
      end

      it 'should give 600: for 3 times 6' do
        expect(Greed.points(6, 3)[0]).to eql(600)
        expect(Greed.points(6, 3)[1]).to eql(3)
      end

      it 'should give 500: for 3 times 5' do
        expect(Greed.points(5, 3)[0]).to eql(500)
        expect(Greed.points(5, 3)[1]).to eql(3)
      end

      it 'should give 400: for 3 times 4' do
        expect(Greed.points(4, 3)[0]).to eql(400)
        expect(Greed.points(4, 3)[1]).to eql(3)
      end

      it 'should give 300: for 3 times 3' do
        expect(Greed.points(3, 3)[0]).to eql(300)
        expect(Greed.points(3, 3)[1]).to eql(3)
      end

      it 'should give 200: for 3 times 2' do
        expect(Greed.points(2, 3)[0]).to eql(200)
        expect(Greed.points(2, 3)[1]).to eql(3)
      end

      it 'should give 100: for 1 time 1' do
        expect(Greed.points(1, 1)[0]).to eql(100)
        expect(Greed.points(1, 1)[1]).to eql(1)
      end

      it 'should give 50: for 1 time 5' do
        expect(Greed.points(5, 1)[0]).to eql(50)
        expect(Greed.points(5, 1)[1]).to eql(1)
      end
    end

    context 'indirect cases' do
      context 'for 1' do
        it 'should give 200: for 2 times 1' do
          expect(Greed.points(1, 2)[0]).to eql(200)
          expect(Greed.points(1, 2)[1]).to eql(2)
        end

        it 'should give 1100: for 4 times 1' do
          expect(Greed.points(1, 4)[0]).to eql(1100)
          expect(Greed.points(1, 4)[1]).to eql(4)
        end

        it 'should give 1200: for 5 times 1' do
          expect(Greed.points(1, 5)[0]).to eql(1200)
          expect(Greed.points(1, 5)[1]).to eql(5)
        end
      end

      context 'for 2' do
        it 'should give 0: for 1 time 2' do
          expect(Greed.points(2, 1)[0]).to eql(0)
          expect(Greed.points(2, 1)[1]).to eql(0)
        end

        it 'should give 0: for 2 times 2' do
          expect(Greed.points(2, 2)[0]).to eql(0)
          expect(Greed.points(2, 2)[1]).to eql(0)
        end

        it 'should give 200: for 4 times 2' do
          expect(Greed.points(2, 4)[0]).to eql(200)
          expect(Greed.points(2, 4)[1]).to eql(3)
        end

        it 'should give 200: for 5 times 2' do
          expect(Greed.points(2, 5)[0]).to eql(200)
          expect(Greed.points(2, 5)[1]).to eql(3)
        end
      end

      context 'for 3' do
        it 'should give 0: for 1 time 3' do
          expect(Greed.points(3, 1)[0]).to eql(0)
          expect(Greed.points(3, 1)[1]).to eql(0)
        end

        it 'should give 0: for 2 times 3' do
          expect(Greed.points(3, 2)[0]).to eql(0)
          expect(Greed.points(3, 2)[1]).to eql(0)
        end

        it 'should give 300: for 4 times 3' do
          expect(Greed.points(3, 4)[0]).to eql(300)
          expect(Greed.points(3, 4)[1]).to eql(3)
        end

        it 'should give 300: for 5 times 3' do
          expect(Greed.points(3, 5)[0]).to eql(300)
          expect(Greed.points(3, 5)[1]).to eql(3)
        end
      end

      context 'for 4' do
        it 'should give 0: for 1 time 4' do
          expect(Greed.points(4, 1)[0]).to eql(0)
          expect(Greed.points(4, 1)[1]).to eql(0)
        end

        it 'should give 0: for 2 times 4' do
          expect(Greed.points(4, 2)[0]).to eql(0)
          expect(Greed.points(4, 2)[1]).to eql(0)
        end

        it 'should give 400: for 4 times 4' do
          expect(Greed.points(4, 4)[0]).to eql(400)
          expect(Greed.points(4, 4)[1]).to eql(3)
        end

        it 'should give 400: for 5 times 4' do
          expect(Greed.points(4, 5)[0]).to eql(400)
          expect(Greed.points(4, 5)[1]).to eql(3)
        end
      end

      context 'for 5' do
        it 'should give 100: for 2 times 5' do
          expect(Greed.points(5, 2)[0]).to eql(100)
          expect(Greed.points(5, 2)[1]).to eql(2)
        end

        it 'should give 550: for 4 times 5' do
          expect(Greed.points(5, 4)[0]).to eql(550)
          expect(Greed.points(5, 4)[1]).to eql(4)
        end

        it 'should give 600: for 5 times 5' do
          expect(Greed.points(5, 5)[0]).to eql(600)
          expect(Greed.points(5, 5)[1]).to eql(5)
        end
      end

      context 'for 6' do
        it 'should give 0: for 1 time 6' do
          expect(Greed.points(6, 1)[0]).to eql(0)
          expect(Greed.points(6, 1)[1]).to eql(0)
        end

        it 'should give 0: for 2 times 6' do
          expect(Greed.points(6, 2)[0]).to eql(0)
          expect(Greed.points(6, 2)[1]).to eql(0)
        end

        it 'should give 600: for 4 times 6' do
          expect(Greed.points(6, 4)[0]).to eql(600)
          expect(Greed.points(6, 4)[1]).to eql(3)
        end

        it 'should give 600: for 5 times 6' do
          expect(Greed.points(6, 5)[0]).to eql(600)
          expect(Greed.points(6, 5)[1]).to eql(3)
        end
      end
    end
  end
end
