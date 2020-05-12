# require 'rspec/autorun'
#spec/script_test.rb
# RSpec.describe Enumerable do

require_relative '../script.rb'

describe Enumerable do
    describe '#my_each' do
      let(:fruits){%w[apple banana strawberry pineapple]}
      context 'Test case for my_each' do
        it 'returns each element of an array' do
          e = fruits.my_each
          f = fruits.each
          (fruits.count).times do
            expect(e.next).to eql(f.next)
          end
        end
      end
    end

    describe '#my_each_with_index' do
      let(:fruits){%w[apple banana strawberry pineapple]}
      context 'Test case for my_each_with_index' do
        it 'returns key and value of array' do
          selected = []
          selected1 = []

          fruits.my_each_with_index { |fruit, index|  selected << fruit if index.even? }
          fruits.each_with_index { |fruit, index|  selected1 << fruit if index.even? }
          expect(selected).to eql(selected1)
        end
        end
    end

    describe '#my_select' do
      let(:friends){%w[Sharon Leo Leila Brian Arun]}
      context 'Test case for my_select' do
        it 'Returns array' do
          array1 = friends.my_select { |friend| friend != 'Brian' }
          array2 = friends.select { |friend| friend != 'Brian' }
          expect(array1).to eql(array2)
        end
      end


    end

    describe '#my_any?' do
      let(:case1) {[nil, false, true, []]}
      let(:case2){%w[ant bear cat]} #.any?} { |word| word.length >= 3 } #=> true
      let(:case4){%w[ant bear cat]} #.any?(/d/)                        #=> false
      let(:case5){[nil, true, 99]} #.any?(Integer)                     #=> true
      let(:case7){[]}#.any?
      context 'Test case for my_any?' do
        it 'returns true for [nil, false, true, []].my_any?' do
          expect(case1.my_any? ).to eql(case1.any?)
        end
        it 'returns true for %w[ant bear cat].my_any?} { |word| word.length >= 3 }' do
          test1= case2.my_any? { |word| word.length >= 3 }
          test2= case2.any? { |word| word.length >= 3 }
          expect(test1).to eql(test2)
        end
        it 'returns false for %w[ant bear cat].my_any?(/d/) ' do
          expect(case4.my_any?(/d/)).to eql(case4.any?(/d/))
        end
        it 'returns true for [nil, true, 99].my_any?(Integer) ' do
          expect(case5.my_any?(Integer)).to eql(case5.any?(Integer))
        end
        it 'returns false for [].my_any? ' do
          expect(case7.my_any?).to eql(case7.any?)
        end
      end
    end

    describe '#my_all?' do
        let(:cade1) {[nil, false, true, []]}
        let(:cade2) {[19, 59, 70, 23, 140]}
        let(:cade3) {%w[ant bear cat]}
        let(:cade4) {[nil, false, true, 99]}
        let(:cade5) {[3,"3",3]}
        context 'Test cases for my_all' do
          it '[nil, false, true, []].my_all? ' do
            expect(cade1.my_all? ).to eql(cade1.all?)
          end
          it '[19, 59, 70, 23, 140].my_all?{ |age| age > 10 && age <= 222 }  ' do
            expect(cade2.my_all?{ |age| age > 10 && age <= 222 } ).to eql(cade2.all?{ |age| age > 10 && age <= 222 })
          end
          it '%w[ant bear cat]' do
            expect(cade3.my_all?(/a/) ).to eql(cade3.all?(/a/))
          end
          it ' [nil, false, true, 99]' do
            expect(cade4.my_all? ).to eql(cade4.all?)
          end
          it '[3,"3",3].all?(Numeric)' do
            expect(cade5.my_all?(Numeric) ).to eql(cade5.all?(Numeric))
          end
        end
    end

    describe '#my_count' do
      let(:ary){[1, 2, 4, 2]}
      context 'Test cases for my_count' do
          it '[1, 2, 4, 2].my_count' do
            expect(ary.my_count).to eql(ary.count)
          end
          it '[1, 2, 4, 2].my_count{ |x| x%2==0 } ' do
            expect(ary.my_count{ |x| x%2==0 } ).to eql(ary.count{ |x| x%2==0 })
          end
          it '[1, 2, 4, 2].my_count(2)' do
            expect(ary.my_count(2) ).to eql(ary.count(2))
          end
        end
    end

    describe '#my_map' do
      let(:case1){[1,2,3,4]}
      context 'Test cases for my_map' do
          it 'returns array from [1,2,3,4].my_map { |i| i*i } ' do
            expect(case1.my_map{|i| i*i}).to eql(case1.map{|i| i*i})
          end
        end

    end

    describe '#my_none?' do
      let(:case1) {[nil, false, true, []]}
      let(:case2){%w[ant bear cat]}
      let(:case4){%w[ant bear cat]}
      let(:case5){[nil, true, 99]}
      let(:case7){[]}
      context 'Test case for my_none?' do
        it 'returns false for [nil, false, true, []].my_none?' do
          expect(case1.my_none? ).to eql(case1.none?)
        end
        it 'returns false for %w[ant bear cat].my_none?} { |word| word.length >= 3 }' do
          test1= case2.my_none? { |word| word.length >= 3 }
          test2= case2.none? { |word| word.length >= 3 }
          expect(test1).to eql(test2)
        end
        it 'returns true for %w[ant bear cat].my_none?(/d/) ' do
          expect(case4.my_none?(/d/)).to eql(case4.none?(/d/))
        end
        it 'returns false for [nil, true, 99].my_none?(Integer) ' do
          expect(case5.my_none?(Integer)).to eql(case5.none?(Integer))
        end
        it 'returns true for [].my_none? ' do
          expect(case7.my_none?).to eql(case7.none?)
        end
      end

    end

    describe '#my_inject' do
      let(:array) {Array.new(10) { rand(0...10) }}
      let(:operation){proc { |sum, n| sum + n }}

       context 'Test cases for my_all' do
          it 'Array.new(10) { rand(0...10).my_inject(proc { |sum, n| sum + n }) ' do
            expect(array.my_inject(&operation) ).to eql(array.inject(&operation))
          end
          it 'Array.new(10) { rand(0...10).my_inject(:+)' do
            expect(array.my_inject(:+)).to eql(array.inject(:+))
          end
          it 'Array.new(10) { rand(0...10).my_inject(2,:*)' do
            expect(array.my_inject(2,:*)).to eql(array.inject(2,:*))
          end
          it 'Array.new(10) { rand(0...10).my_inject(2){|product, n| product * n}' do
            expect(array.my_inject(2){|product, n| product * n}).to eql(array.inject(2){|product, n| product * n})
          end
        end

    end

end