require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::ampdb' do

  before :example do
    @eps = 1e-6
    @random_pitches =
    [
      NumericTester.new(0.5, -6.020599913),
      NumericTester.new(1.0, 0.0),
      NumericTester.new(8.0, +18.06179973983887),
    ]
  end

  it 'has a ampdb method that works' do
    Numeric.reset_pitch_fork
    @random_pitches.each do
      |rp|
      expect(rp.from.ampdb).to(be_within(@eps).of(rp.to), "#{rp.from.ampdb} != #{rp.to}")
    end
  end

  it 'raises an Exception within ampdb if the receiver is negative' do
    Numeric.reset_pitch_fork
    expect { -128.ampdb }.to raise_error(Mext::NegativeNumeric)
  end

end

