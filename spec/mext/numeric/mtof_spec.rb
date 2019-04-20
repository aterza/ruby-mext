require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe Numeric do

  before :example do
    @eps = 1e-6
    @new_pitch_fork = 442.6
    @random_pitches =
    [
      NumericTester.new(261.6255653005986, 60.0),
      NumericTester.new(128, 47.62368343770),
      NumericTester.new(756222.2300000156, 197.96509224598),
      NumericTester.new(Numeric::DEFAULT_PITCH_FORK, Numeric::MIDI_PITCH_FORK),
    ]
  end

  it 'has a mtof method that works' do
    Numeric.reset_pitch_fork
    @random_pitches.each do
      |rp|
      expect(rp.midi.mtof).to(be_within(@eps).of(rp.freq), "#{rp.midi.mtof} != #{rp.freq}")
    end
  end

  it 'raises an Exception within mtof if the receiver is negative' do
    Numeric.reset_pitch_fork
    expect { -128.mtof }.to raise_error(Numeric::NegativeNumeric)
  end

end
