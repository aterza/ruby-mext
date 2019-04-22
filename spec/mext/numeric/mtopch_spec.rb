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
      NumericTester.new(-36.0, 0.00),
      NumericTester.new(-37.0, -0.01),
      NumericTester.new(-48.0, -1.00),
      NumericTester.new(-57.0, -1.09),
    ]
  end

  it 'has a mtopch method that works' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.mtopch).to(be_within(@eps).of(rp.to), "#{rp.from.mtopch} != #{rp.to}")
    end
  end

end
