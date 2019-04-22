require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::pchtom' do

  before :example do
    @eps = 1e-6
    @dataset =
    [
      NumericTester.new(8.00, 60.0),
      NumericTester.new(0.001, -35.9),
      NumericTester.new(8.09, 69.0),
      NumericTester.new(8.09025, 69.025),
    ]
  end

  it 'has a pchtom method that works' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |rp|
      expect(rp.from.pchtom).to(be_within(@eps).of(rp.to), "#{rp.from.pchtom} != #{rp.to}")
    end
  end

end
