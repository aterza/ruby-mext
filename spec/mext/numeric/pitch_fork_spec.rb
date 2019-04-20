require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::pitch_fork' do

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

  it 'has a pitch fork setter class method' do
    expect(Numeric.respond_to?(:pitch_fork=)).to be true
  end

  it 'has a pitch fork getter class method' do
    expect(Numeric.respond_to?(:pitch_fork)).to be true
  end

  it 'has a reset_pitch_fork class method that works' do
    expect(Numeric.respond_to?(:reset_pitch_fork)).to be true
    expect(Numeric.reset_pitch_fork).to eq(Numeric::DEFAULT_PITCH_FORK)
    expect(Numeric.pitch_fork = @new_pitch_fork).to eq(@new_pitch_fork)
    expect(Numeric.pitch_fork).to eq(@new_pitch_fork)
    expect(Numeric.reset_pitch_fork).to eq(Numeric::DEFAULT_PITCH_FORK)
    expect(Numeric.pitch_fork).to eq(Numeric::DEFAULT_PITCH_FORK)
  end

  it 'has a pitch fork attribute that works' do
    #
    # falls back to default when set
    #
    expect(Numeric.pitch_fork).to eq(Numeric::DEFAULT_PITCH_FORK)
    #
    # it can be set to a new value
    #
    expect(Numeric.pitch_fork = @new_pitch_fork).to eq(@new_pitch_fork)
    #
    # it stays there once it is set
    #
    expect(Numeric.pitch_fork).to eq(@new_pitch_fork)
    #
    # numbers see it
    #
    @random_pitches.each do
      |rp|
      expect(rp.freq.class.pitch_fork).to(eq(@new_pitch_fork), rp.freq.to_s)
      expect(rp.midi.class.pitch_fork).to(eq(@new_pitch_fork), rp.midi.to_s)
    end
  end

end
