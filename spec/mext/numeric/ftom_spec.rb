require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::ftom' do

  before :example do
    @eps = 1e-6
    @new_pitch_fork = 443.5
    @intv_pitch_fork = @new_pitch_fork / Numeric::DEFAULT_PITCH_FORK
    @dataset =
    [
      NumericTester.new(261.6255653005986, 60.0),
      NumericTester.new(0.0050297173601206915, -128.0),
      NumericTester.new(128.0, 47.62368343770),
      NumericTester.new(756222.2300000156, 197.96509224598),
      NumericTester.new(Numeric::DEFAULT_PITCH_FORK, Numeric::MIDI_PITCH_FORK),
      NumericTester.new(1.0827446522534065, -35.0),
      NumericTester.new(0.9646158227658674, -37.0),
    ]
  end

  it 'has a :ftom method that works' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.ftom).to(be_within(@eps).of(rp.to), "#{rp.from.ftom} != #{rp.to}")
    end
  end

  it 'has a :ftom method that is the reciprocal of the :mtof one' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.ftom.mtof).to(be_within(@eps).of(rp.from), "#{rp.from.ftom.mtof} != #{rp.from}")
    end
  end

  it 'has a :ftom method that works even if the pitch fork changes' do
    Numeric.pitch_fork = @new_pitch_fork
    @dataset.each do
      |rp|
      expect((rp.from*@intv_pitch_fork).ftom).to(be_within(@eps).of(rp.to), "#{(rp.from*@intv_pitch_fork).ftom} != #{rp.to}")
    end
  end

  it 'has a :ftom method that is the reciprocal of the :mtof one even if the pitch fork changes' do
    Numeric.pitch_fork = @new_pitch_fork
    @dataset.each do
      |rp|
      expect((rp.from*@intv_pitch_fork).ftom.mtof).to(be_within(@eps).of(rp.from*@intv_pitch_fork), "#{(rp.from*@intv_pitch_fork).ftom.mtof} != #{rp.from*@intv_pitch_fork}")
    end
  end

  it 'raises an Exception within ftom if the receiver is negative' do
    Numeric.reset_pitch_fork
    expect { -128.ftom }.to raise_error(Mext::NegativeNumeric)
  end

end
