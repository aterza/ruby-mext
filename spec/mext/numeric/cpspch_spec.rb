require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::cpspch' do

  before :example do
    @eps = 1e-4
    @dataset_positive =
    [
      NumericTester.new(261.63, 8.00),
      NumericTester.new(440.0,  8.09),
      NumericTester.new(446.40, 8.0925),
    ]
    @dataset_negative =
    [
      NumericTester.new(0.0, 3.0),
      NumericTester.new(-1.0, -0.01),
      NumericTester.new(-12.0, -1.00),
      NumericTester.new(-18.0, -1.09),
    ]
  end

  it 'has a cpspch method that works with positive frequency values' do
    Numeric.reset_pitch_fork
    @dataset_positive.each do
      |rp|
      expect(rp.from.cpspch).to(be_within(@eps).of(rp.to), "#{rp.from.cpspch} != #{rp.to}")
    end
  end

  it 'raises an error when passed a negative frequency' do
    Numeric.reset_pitch_fork
    @dataset_negative.each do
      |rp|
      expect { rp.from.cpspch }.to raise_error(Numeric::NegativeNumeric)
    end
  end

end

