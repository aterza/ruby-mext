require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::pchcps' do

  before :example do
    @eps = 1e-8
    @dataset_positive =
    [
      NumericTester.new(8.00, 261.6255653005986),
      NumericTester.new(8.09, 440.0),
      NumericTester.new(8.0925, 446.39994737250896),
      NumericTester.new(0.0, 1.0219748644554634),
      NumericTester.new(-1.0, 0.5109874322277317),
      NumericTester.new(-12.0, 0.0002495055821424471),
      NumericTester.new(-18.0, 3.898524720975736e-06),
    ]
  end

  it 'has a pchcps method that works with positive frequency values' do
    Numeric.reset_pitch_fork
    @dataset_positive.each do
      |rp|
      expect(rp.from.pchcps).to(be_within(@eps).of(rp.to), "#{rp.from.pchcps} != #{rp.to}")
    end
  end

end
