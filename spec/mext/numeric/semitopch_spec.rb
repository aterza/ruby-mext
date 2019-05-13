require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::semitopch' do

  before :example do
    @eps = 1e-6
    @dataset =
    [
      NumericTester.new(96.0, 8.00),
      NumericTester.new(105.0, 8.09),
      NumericTester.new(105.025, 8.09025),
      NumericTester.new(1.0, 0.01),
      NumericTester.new(0.0, 0.00),
      NumericTester.new(-1.0, -0.01),
      NumericTester.new(-12.0, -1.00),
      NumericTester.new(-13.0, -1.01),
      NumericTester.new(-21.0, -1.09),
      NumericTester.new(-22.0, -1.10),
    ]
    @top_semitone = 216
    @bot_semitone = -216
    @oct = 18
    @semi = 0
    @semi_step = 0.1
  end

  it 'has a semitopch method that works' do
    @dataset.each do
      |rp|
      expect(rp.from.semitopch).to(be_within(@eps).of(rp.to), "#{rp.from.semitopch} != #{rp.to}")
    end
  end

  it 'has a :semitopch method that is the reciprocal of the :pchtosemi one' do
    @dataset.each do
      |rp|
      expect(rp.from.semitopch.pchtosemi).to(be_within(@eps).of(rp.from), "#{rp.from.semitopch.pchtosemi} != #{rp.from}")
    end
  end

  it 'works for each and every semitone' do
    @top_semitone.step(@bot_semitone, -@semi_step).each do
      |s|
      oct = (s / Numeric::CNPO).to_i
      semi = s - (oct * Numeric::CNPO)
      semi %= Numeric::CNPO
      semi = s >= 0.0 ? semi : -((Numeric::CNPO - semi) % Numeric::CNPO)
      pch = oct + (semi / Numeric::PCC)
      expect(s.semitopch).to(be_within(@eps).of(pch), "#{s}.semitopch (#{s.semitopch}) != #{pch}")
      expect(s.semitopch.pchtosemi).to(be_within(@eps).of(s), "#{s}.semitopch.pchtosemi (#{s.semitopch.pchtosemi}) != #{s}")
    end

  end

end
