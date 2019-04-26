require "spec_helper"
require File.expand_path(File.join('..', 'numeric_tester'), __FILE__)

describe 'Numeric::rrand' do

  before :example do
    @dataset = [ [0.0, 5.0], [-1500.0, 1500.0], [-23.0, -21.0], [0, 15.5], [0.0, 15], ]
  end

  it 'has a rrand method that works for float values' do
    @dataset.each do
      |lower, upper|
      expect((res = lower.rrand(upper)).is_a?(Float)).to be true
      expect(res).to(be_between(lower, upper), "#{res} not between #{lower} and #{upper}")
    end
  end

  it 'does work with no argument (i.e. with a default)' do
    @dataset.each do
      |lower, upper|
      expect((res = lower.to_f.rrand).is_a?(Float)).to be true
      if lower >= 0
        expect(res).to(be_between(0, lower), "#{res} not between 0.0 and #{lower}")
      else
        expect(res).to(be_between(lower, 0), "#{res} not between #{lower} and 0.0")
      end
    end
  end

end

describe 'Integer::rrand' do

  before :example do
    @dataset   = [ [0, 5], [-1500, 1500], [-23, -21], ]
    @should_be_float = [ [0, 5.5], [-20, 20.0 ], ]
  end

  it 'has a rrand method that works for integer values' do
    Numeric.reset_pitch_fork
    @dataset.each do
      |lower, upper|
      expect((res = lower.rrand(upper)).is_a?(Integer)).to be true
      expect(res).to(be_between(lower, upper), "#{res} not between #{lower} and #{upper}")
    end
  end

  it 'has a rrand method that returns float values for mixed arguments' do
    Numeric.reset_pitch_fork
    @should_be_float.each do
      |lower, upper|
      expect((res = lower.rrand(upper)).is_a?(Float)).to be true
      expect(res).to(be_between(lower, upper), "#{res} not between #{lower} and #{upper}")
    end
  end

  it 'does work with no argument (i.e. with a default)' do
    @dataset.each do
      |lower, upper|
      expect((res = lower.rrand).is_a?(Integer)).to be true
      if lower >= 0
        expect(res).to(be_between(0, lower), "#{res} not between 0 and #{lower}")
      else
        expect(res).to(be_between(lower, 0), "#{res} not between #{lower} and 0")
      end
    end
  end

end
