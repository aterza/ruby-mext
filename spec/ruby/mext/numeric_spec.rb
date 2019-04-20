require "spec_helper"

describe Numeric do

  class NumericTester
    attr_reader :freq, :midi

    def initialize(f, m)
      @freq = f
      @midi = m
    end
  end

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
