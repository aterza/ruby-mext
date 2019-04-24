require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::ftom' do

  before :example do
    @eps = 1e-6
    @random_pitches =
    [
      NumericTester.new(261.6255653005986, 60.0),
      NumericTester.new(0.0050297173601206915, -128.0),
      NumericTester.new(128.0, 47.62368343770),
      NumericTester.new(756222.2300000156, 197.96509224598),
      NumericTester.new(Numeric::DEFAULT_PITCH_FORK, Numeric::MIDI_PITCH_FORK),
    ]
  end

  it 'has a ftom method that works' do
    Numeric.reset_pitch_fork
    @random_pitches.each do
      |rp|
      expect(rp.from.ftom).to(be_within(@eps).of(rp.to), "#{rp.from.ftom} != #{rp.to}")
    end
  end

  it 'raises an Exception within ftom if the receiver is negative' do
    Numeric.reset_pitch_fork
    expect { -128.ftom }.to raise_error(Mext::NegativeNumeric)
  end

end
