require "spec_helper"

describe 'Array::vectorize' do

  before :example do
    @datasets =
    [
      [ 10, 36, 22, 21, 1e-18, 23e18, ],
      [ 1 ], # data set with one element
      [ 1, 2 ], # data set with two elements
    ]
  end

  @vectorized_methods = Mext::Numeric::VECTORIZABLE_METHODS.map { |m| m.to_sym }
  @non_vectorized_methods = Mext::Numeric::NON_VECTORIZABLE_METHODS.map { |m| m.to_sym }

  @vectorized_methods.each do
     |m|
     it "has a :#{m.to_s} method that works" do
       @datasets.each do
         |array|
         expect(array.respond_to?(m)).to(be(true), m.to_s)
         expect(array.send(m).size).to(eq(array.size), m.to_s)
       end
     end
  end

  @non_vectorized_methods.each do
     |m|
     it "does not have a :#{m.to_s} method" do
       @datasets.each do
         |array|
         expect(array.respond_to?(m)).to(be(false), m.to_s)
         expect { array.send(m) }.to(raise_error(NoMethodError), m.to_s)
       end
     end
  end

end
