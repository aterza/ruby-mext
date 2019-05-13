require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::pchtosemi' do

  before :example do
    @eps = 1e-6
    @dataset =
    [
      NumericTester.new(8.00, 96.0),
      NumericTester.new(8.09, 105.0),
      NumericTester.new(8.09025, 105.025),
      NumericTester.new(0.01,    1.0),
      NumericTester.new(0.00,    0.0),
      NumericTester.new(-0.01,  -1.0),
      NumericTester.new(-1.00, -12.0),
      NumericTester.new(-1.04, -16.0),
      NumericTester.new(-1.01, -13.0),
      NumericTester.new(-1.09, -21.0),
      NumericTester.new(-1.10, -22.0),
    ]
    @top_octave = 17.0
    @bot_octave = -17.0
    @top_semi = 11.0
    @bot_semi = 0.0
    @top_semitone = @top_octave * (Numeric::CNPO)
  end

  it 'has a pchtosemi method that works' do
    @dataset.each do
      |rp|
      expect(rp.from.pchtosemi).to(be_within(@eps).of(rp.to), "#{rp.from.pchtosemi} != #{rp.to}")
    end
  end

  it 'has a :pchtosemi method that is the reciprocal of the :semitopch one' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.pchtosemi.semitopch).to(be_within(@eps).of(rp.from), "#{rp.from.pchtosemi.semitopch} != #{rp.from}")
    end
  end

  it 'works for each and every pitch class' do
    should_be = @top_semitone - 1
    (@top_octave-1).step(0.0, -1.0).each do
      |oct|
      @top_semi.step(@bot_semi, -1.0).each do
        |semi|
        pch = oct + (semi / Numeric::PCC)
        expect(pch.pchtosemi).to(be_within(@eps).of(should_be), "#{pch}.pchtosemi (#{pch.pchtosemi}) != #{should_be}")
        expect(pch.pchtosemi.semitopch).to(be_within(@eps).of(pch), "#{pch}.pchtosemi.semitopch (#{pch.pchtosemi.semitopch}) != #{pch}")
        should_be -= 1
      end
    end
    0.0.step(@bot_oct, -1.0).each do
      |oct|
      @bot_semi.step(@top_semi, 1.0).each do
        |semi|
        pch = oct + (semi / Numeric::PCC)
        expect(pch.pchtosemi).to(be_within(@eps).of(should_be), "#{pch}.pchtosemi (#{pch.pchtosemi}) != #{should_be}")
        expect(pch.pchtosemi.semitopch).to(be_within(@eps).of(pch), "#{pch}.pchtosemi.semitopch (#{pch.pchtosemi.semitopch}) != #{pch}")
        should_be -= 1
      end
    end
  end

end
