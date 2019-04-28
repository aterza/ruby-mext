require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::mmtot' do

  before :example do
    @eps = 1e-8
    @dataset_quarter =
    [
      NumericTester.new(120, 0.5),
      NumericTester.new(60, 1),
      NumericTester.new(96.0, 0.625),
      NumericTester.new(48.0, 0.625*2),
    ]
    @subdivisions = [ 1/2.0, 3.0, 4 + (1/3.0), 7.0 ]
  end

  it 'has a mmtot method that works with quarter note values' do
    @dataset_quarter.each do
      |rp|
      expect(rp.from.mmtot).to(be_within(@eps).of(rp.to), "#{rp.from.mmtot} != #{rp.to}")
    end
  end

  it 'has a mmtot method that works with a numerator for subdivisions' do
    @subdivisions.each do
      |subd|
      @dataset_quarter.each do
        |rp|
        expect(rp.from.mmtot(subd)).to(be_within(@eps).of(rp.to*subd), "#{rp.from.mmtot(subd)} != #{rp.to*subd} for subdivision: #{subd}")
      end
    end
  end

end
