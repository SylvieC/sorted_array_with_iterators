require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          expect { sorted_array.map {|el| el } }.to_not change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map

        it 'creates a new array containing the values returned by the block' do
          sorted_array.map{|el| el + 4}.should eq source
        end
      end
    end

    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
          sorted_array.map! { |ele| 1 + ele}.should eq [3,4,5,8,10]
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do
          sorted_array.map!{|ele| ele + 2}.should eq [4, 5, 6, 9, 11]
        end
      end
    end
  end

  describe :find do
    

    it "returns the first element that return true for the block" do
       sorted_array.find("none"){|ele| ele % 2 == 0 }.should eq 2
    end

    it "returns none when there are no elements that match the block" do
      sorted_array.find("none"){|ele| ele % 5 == 0 }.should eq "none"
    end
  end

  describe :inject do

    # it_should_behave_like "yield to all elements in sorted array", :inject
  # end

    it "behaves as planned" do
      sorted_array.inject(1){ |sum, value|  sum + value}.should eq 26
    end
  end
end