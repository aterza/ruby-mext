require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::pchtom' do

  before :example do
    @eps = 1e-6
    @dataset =
    [
      NumericTester.new(8.00, 60.0),
      NumericTester.new(8.09, 69.0),
      NumericTester.new(8.09025, 69.025),
      NumericTester.new(0.01, -35.0),
      NumericTester.new(0.00, -36.0),
      NumericTester.new(-0.01, -37.0),
      NumericTester.new(-1.00, -48.0),
      NumericTester.new(-1.04, -52.0),
      NumericTester.new(-1.01, -49.0),
      NumericTester.new(-1.09, -57.0),
      NumericTester.new(-1.10, -58.0),
    ]
    @top_octave = 17.0
    @bot_octave = -17.0
    @top_semi = 11.0
    @bot_semi = 0.0
    @top_midi_note = 179
  end

  it 'has a pchtom method that works' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.pchtom).to(be_within(@eps).of(rp.to), "#{rp.from.pchtom} != #{rp.to}")
    end
  end

  it 'has a :pchtom method that is the reciprocal of the :mtopch one' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.pchtom.mtopch).to(be_within(@eps).of(rp.from), "#{rp.from.pchtom.mtopch} != #{rp.from}")
    end
  end

  it 'works for each and every pitch class' do
    midi_n = @top_midi_note
    @top_octave.step(0.0, -1.0).each do
      |oct|
      @top_semi.step(@bot_semi, -1.0).each do
        |semi|
        pch = oct + (semi / Numeric::PCC)
        expect(pch.pchtom).to(be_within(@eps).of(midi_n), "#{pch}.pchtom (#{pch.pchtom}) != #{midi_n}")
        expect(pch.pchtom.mtopch).to(be_within(@eps).of(pch), "#{pch}.pchtom.mtopch (#{pch.pchtom.mtopch}) != #{pch}")
        midi_n -= 1
      end
    end
    0.0.step(@bot_oct, -1.0).each do
      |oct|
      @bot_semi.step(@top_semi, 1.0).each do
        |semi|
        pch = oct + (semi / Numeric::PCC)
        expect(pch.pchtom).to(be_within(@eps).of(midi_n), "#{pch}.pchtom (#{pch.pchtom}) != #{midi_n}")
        expect(pch.pchtom.mtopch).to(be_within(@eps).of(pch), "#{pch}.pchtom.mtopch (#{pch.pchtom.mtopch}) != #{pch}")
        midi_n -= 1
      end
    end
  end

end
