require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::gold' do

  before :example do
    @eps = 1e-8
    @dataset =
    [
      NumericTester.new(-4.0, 0.145898033750),
      NumericTester.new(-3.5, 0.185585165756),
      NumericTester.new(-3.0, 0.236067977500),
      NumericTester.new(-2.5, 0.300283106001),
      NumericTester.new(-2.0, 0.381966011250),
      NumericTester.new(-1.5, 0.485868271757),
      NumericTester.new(-1.0, 0.618033988750),
      NumericTester.new(-0.5, 0.786151377757),
      NumericTester.new(+0.0, 1.000000000000),
      NumericTester.new(+0.5, 1.272019649514),
      NumericTester.new(+1.0, 1.618033988750),
      NumericTester.new(+1.5, 2.058171027271),
      NumericTester.new(+2.0, 2.618033988750),
      NumericTester.new(+2.5, 3.330190676786),
      NumericTester.new(+3.0, 4.236067977500),
      NumericTester.new(+3.5, 5.388361704057),
      NumericTester.new(+4.0, 6.854101966250),
      NumericTester.new(+4.5, 8.718552380843),
    ]
  end

  it 'has a gold method that works' do
    @dataset.each do
      |rp|
      expect(1.gold(rp.from)).to(be_within(@eps).of(rp.to), "1.gold(#{rp.from}) != #{rp.to}")
    end
  end

end
