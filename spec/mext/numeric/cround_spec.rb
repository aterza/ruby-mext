require "spec_helper"

describe 'Numeric::cround' do

  before :example do
    @eps_pow = -2.0.step(-20.0, -1.0).map { |n| n }
  end

  it 'has a cround method that works for float values' do
    @eps_pow.each do
      |ep|
      eps = 10.0**(ep)
      -10.step(10.0, 1.0).each do
        |val|
        input_val_to_round = val + (eps * 0.5)
        input_val_not_to_round = val + (eps * 1.5)
        expect((res = input_val_to_round.cround(eps))).to(be_within(eps).of(val.round), "#{res} != #{val.round}")
        expect((res = input_val_not_to_round.cround(eps))).to(be_within(eps).of(input_val_not_to_round), "#{res} != #{input_val_not_to_round}")
      end
    end
  end

  it 'does work with no argument (i.e. with a default)' do
    eps = Numeric::DEFAULT_CROUND_EPS
    -10.step(10.0, 1.0).each do
      |val|
      input_val_to_round = val + (eps * 0.5)
      input_val_not_to_round = val + (eps * 1.5)
      expect((res = input_val_to_round.cround(eps))).to(be_within(eps).of(val.round), "#{res} != #{val.round}")
      expect((res = input_val_not_to_round.cround(eps))).to(be_within(eps).of(input_val_not_to_round), "#{res} != #{input_val_not_to_round}")
    end
  end

end
