require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::dbamp' do

  before :example do
    @eps = 1e-6
    @random_pitches =
    [
      NumericTester.new(-6.020599913, 0.5),
      NumericTester.new(0.0, 1.0),
      NumericTester.new(+18.06179973983887, 8.0),
    ]
  end

  it 'has a dbamp method that works' do
    Numeric.reset_pitch_fork
    @random_pitches.each do
      |rp|
      expect(rp.from.dbamp).to(be_within(@eps).of(rp.to), "#{rp.from.dbamp} != #{rp.to}")
    end
  end

end
