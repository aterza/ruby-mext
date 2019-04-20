require "spec_helper"

describe Numeric do

  before :example do
    @new_pitch_fork = 442.6
    @random_pitches = [261.6, -128, 756222.23]
  end

  it 'has a pitch fork setter class method' do
    expect(Numeric.respond_to?(:pitch_fork=)).to be true
  end

  it 'has a pitch fork getter class method' do
    expect(Numeric.respond_to?(:pitch_fork)).to be true
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
    @random_pitches.each { |rp| expect(rp.class.pitch_fork).to(eq(@new_pitch_fork), rp.to_s) }
  end

end
