require "spec_helper"

describe 'Array::choose' do

  @rounds = 5
  @datasets =
  [
    [ -10, 36, 22, 21, 1e-18, 23e18, ],
    [ 1 ], # data set with one element
    [ 1, 2 ], # data set with two elements
  ]

  @datasets.each do
    |array|
    0.upto(@rounds) do
      |n|
      describe array do
        it { is_expected.to include(array.choose) }
      end
    end
  end

  it 'is expected to return nil on an empty array' do
    expect([].choose).to be nil
  end

end
