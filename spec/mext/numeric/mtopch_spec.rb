require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::mtopch' do

  before :example do
    @eps = 1e-6
    @dataset =
    [
      NumericTester.new(60.0, 8.00),
      NumericTester.new(69.0, 8.09),
      NumericTester.new(69.025, 8.09025),
      NumericTester.new(-35.0, 0.01),
      NumericTester.new(-36.0, 0.00),
      NumericTester.new(-37.0, -0.01),
      NumericTester.new(-48.0, -1.00),
      NumericTester.new(-49.0, -1.01),
      NumericTester.new(-57.0, -1.09),
      NumericTester.new(-58.0, -1.10),
    ]
    @top_midi_note = 180
    @bot_midi_note = -180
    @oct = 18
    @semi = 0
  end

  it 'has a mtopch method that works' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.mtopch).to(be_within(@eps).of(rp.to), "#{rp.from.mtopch} != #{rp.to}")
    end
  end

  it 'has a :mtopch method that is the reciprocal of the :pchtom one' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.mtopch.pchtom).to(be_within(@eps).of(rp.from), "#{rp.from.mtopch.pchtom} != #{rp.from}")
    end
  end

  it 'works for each and every midi note' do
    @top_midi_note.step(@bot_midi_note, -1).each do
      |midi_n|
      @semi = (midi_n - Numeric::ZMP) / Numeric::CNPO
      @oct = @semi.to_i
      @semi = (@semi - @oct) * Numeric::CNPO
      @semi %= Numeric::CNPO
      @semi = midi_n > Numeric::ZMP ? @semi : -((Numeric::CNPO - @semi) % Numeric::CNPO)
      pch = @oct + (@semi / Numeric::PCC)
      expect(midi_n.mtopch).to(be_within(@eps).of(pch), "#{midi_n}.mtopch (#{midi_n.mtopch}) != #{pch}")
      expect(midi_n.mtopch.pchtom).to(be_within(@eps).of(midi_n), "#{midi_n}.mtopch.pchtom (#{midi_n.mtopch.pchtom}) != #{midi_n}")
    end

  end

end
