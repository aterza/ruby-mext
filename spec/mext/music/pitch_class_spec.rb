require "spec_helper"

describe Mext::Music::PitchClass do

  class PitchClassTester
    attr_reader :float_value, :octave, :semi, :correct_float_value

    def initialize(fv, o, s, cfv)
      @float_value = fv
      @octave = o
      @semi = s
      @correct_float_value = cfv
    end

    def freq
      self.float_value.pchcps
    end

    def semitones
      (self.octave * 12) + self.semi
    end

  end

  before :example do
    @eps = 1e-6
    @dataset = [
       PitchClassTester.new(8.00, 8, 0, 8.0),
       PitchClassTester.new(0.0, 0, 0, 0.0),
       PitchClassTester.new(-3.10, -3, -10, -3.1),
       PitchClassTester.new(8.0925, 8, 9.25, 8.0925),
       PitchClassTester.new(8.55, 12, 7, 12.07),
       PitchClassTester.new(-8.55, -12, -7, -12.07),
       PitchClassTester.new(-0.0, 0, 0, 0.0),
       PitchClassTester.new(-0.01, -0, -1, -0.01),
       PitchClassTester.new(-1.01, -1, -1, -1.01),
       PitchClassTester.new(0.01, 0, 1, 0.01),
       PitchClassTester.new(1.01, 1, 1, 1.01),
    ]
    @instance_methods = [:to_f, :to_freq, :+, :-, :interval, :to_semitones]
    @logic_operators = [[:>, :==, 1], [:>=, :>=, 0], [:<, :==, -1], [:<=, :<=, 0], [:==, :==, 0], [:!=, :!=, 0]]
    @class_methods = [:new, :from_freq]
  end

  it 'can be created with one argument' do
    @dataset.each do
      |pct|
      expect((pc = Mext::Music::PitchClass.new(pct.float_value))).not_to be nil
      expect(pc.to_f).to(be_within(@eps).of(pct.correct_float_value), "pc.to_f #{pc.to_f} != #{pct.correct_float_value}")
      expect(pc.octave).to(be_within(@eps).of(pct.octave), "pc.octave #{pc.octave} != #{pct.octave}")
      expect(pc.semi).to(be_within(@eps).of(pct.semi), "pc.semi #{pc.semi} != #{pct.semi}")
      expect(pc.to_freq).to(be_within(@eps).of(pct.freq), "pc.to_freq #{pc.to_freq} != #{pct.freq}")
    end
  end

  it 'can be created with two arguments' do
   -18.0.step(0.0).each do
      |oct|
      -11.75.step(0.0, 0.25).each do
        |semi|
        rfv = oct + (semi/100.0)
        expect((pct = PitchClassTester.new(rfv, oct, semi, rfv))).not_to be nil
        expect((pc = Mext::Music::PitchClass.new(pct.octave, pct.semi))).not_to(be(nil), "could not create PitchClass for value #{pct.correct_float_value}")
        expect(pc.to_f).to(be_within(@eps).of(pct.correct_float_value), "pc.to_f #{pc.to_f} != #{pct.correct_float_value}")
        expect(pc.octave).to(be_within(@eps).of(pct.octave), "pc.octave #{pc.octave} != #{pct.octave}")
        expect(pc.semi).to(be_within(@eps).of(pct.semi), "pc.semi #{pc.semi} != #{pct.semi}")
        expect(pc.to_freq).to(be_within(@eps).of(pct.freq), "pc.to_freq #{pc.to_freq} != #{pct.freq}")
      end
    end
    0.0.step(18.0).each do
      |oct|
      0.0.step(11.75, 0.25).each do
        |semi|
        rfv = oct + (semi/100.0)
        expect((pct = PitchClassTester.new(rfv, oct, semi, rfv))).not_to be nil
        expect((pc = Mext::Music::PitchClass.new(pct.octave, pct.semi))).not_to(be(nil), "could not create PitchClass for value #{pct.correct_float_value}")
        expect(pc.to_f).to(be_within(@eps).of(pct.correct_float_value), "pc.to_f #{pc.to_f} != #{pct.correct_float_value}")
        expect(pc.octave).to(be_within(@eps).of(pct.octave), "pc.octave #{pc.octave} != #{pct.octave}")
        expect(pc.semi).to(be_within(@eps).of(pct.semi), "pc.semi #{pc.semi} != #{pct.semi}")
        expect(pc.to_freq).to(be_within(@eps).of(pct.freq), "pc.to_freq #{pc.to_freq} != #{pct.freq}")
      end
    end
    #
    # let's try overruning the semitones (above/below 12)
    #
   -18.0.step(0.0).each do
      |oct|
      -23.75.step(-12.00, 0.25).each do
        |semi|
        fv = oct + (semi/100.0)
        rfv = (oct-1) + ((semi % -12.0) / 100.0)
        expect((pct = PitchClassTester.new(fv, oct, semi, rfv))).not_to be nil
        expect((pc = Mext::Music::PitchClass.new(pct.octave, pct.semi))).not_to(be(nil), "could not create PitchClass for value #{pct.correct_float_value}")
        expect(pc.to_f).to(be_within(@eps).of(pct.correct_float_value), "pc.to_f #{pc.to_f} != #{pct.correct_float_value}")
        expect(pc.to_freq).to(be_within(@eps).of(pct.freq), "pc.to_freq #{pc.to_freq} != #{pct.freq}")
      end
    end
    0.0.step(18.0).each do
      |oct|
      12.0.step(23.75, 0.25).each do
        |semi|
        fv = oct + (semi/100.0)
        rfv = (oct+1) + ((semi % 12.0) / 100.0)
        expect((pct = PitchClassTester.new(fv, oct, semi, rfv))).not_to be nil
        expect((pc = Mext::Music::PitchClass.new(pct.octave, pct.semi))).not_to(be(nil), "could not create PitchClass for value #{pct.correct_float_value}")
        expect(pc.to_f).to(be_within(@eps).of(pct.correct_float_value), "pc.to_f #{pc.to_f} != #{pct.correct_float_value}")
        expect(pc.to_freq).to(be_within(@eps).of(pct.freq), "pc.to_freq #{pc.to_freq} != #{pct.freq}")
      end
    end
  end

  it 'has all the methods we are looking for' do
    expect((pc = Mext::Music::PitchClass.new(@dataset.first.correct_float_value))).not_to be nil
    @instance_methods.each do
      |m|
      expect(pc.respond_to?(m)).to(be(true), m.to_s)
    end
    @class_methods.each do
      |m|
      expect(Mext::Music::PitchClass.respond_to?(m)).to(be(true), m.to_s)
    end
  end

  it 'has a :from_freq method that works' do
    @dataset.each do
       |pct|
       expect((mpc = Mext::Music::PitchClass.from_freq(pct.freq))).not_to be nil
       expect((result = mpc.to_freq)).to(be_within(@eps).of(pct.freq), "#{result} != #{pct.freq} for #{mpc.to_f}")
    end
  end

  it 'has a :to_freq method that works' do
    @dataset.each do
       |pct|
       expect((mpc = Mext::Music::PitchClass.new(pct.float_value))).not_to be nil
       expect((result = mpc.to_freq)).to(be_within(@eps).of(pct.freq), "#{result} != #{pct.freq} for #{mpc.to_f}")
    end
  end

  it 'has a :+ method that works' do
    @dataset.each do
       |rpc|
       expect((mpc = Mext::Music::PitchClass.new(rpc.float_value))).not_to be nil
       @dataset.each do
         |opc|
         expect((ompc = Mext::Music::PitchClass.new(opc.float_value))).not_to be nil
         shoct = ((rpc.semitones + opc.semitones) / 12.0)
         shoct = shoct >= 0.0 ? shoct.floor : shoct.ceil
         shrem = (rpc.semitones + opc.semitones) % 12.0
         shremh = (shrem/100.0)
         should_be = shoct >= 0.0 ? (shoct + shremh) : (shoct - shremh)
         expect((smpc = mpc + ompc)).not_to be nil
         expect((result = smpc.to_f)).to(be_within(@eps).of(should_be), "#{result} != #{should_be} for #{rpc.correct_float_value} + #{opc.correct_float_value}")
       end
    end
  end

  it 'has a :- method that works' do
    @dataset.each do
       |rpc|
       expect((mpc = Mext::Music::PitchClass.new(rpc.float_value))).not_to be nil
       @dataset.each do
         |opc|
         expect((ompc = Mext::Music::PitchClass.new(opc.float_value))).not_to be nil
         shoct = ((rpc.semitones - opc.semitones) / 12.0)
         shoct = shoct >= 0.0 ? shoct.floor : shoct.ceil
         shrem = rpc.semitones - opc.semitones
         shrem = shrem >= 0.0 ? (shrem % 12.0) : (shrem % -12.0)
         shremh = (shrem/100.0)
         # should_be = shoct >= 0.0 ? (shoct + shremh) : (shoct - shremh)
         should_be = shoct + shremh
         expect((smpc = mpc - ompc)).not_to be nil
         expect(result = smpc.to_f).to(be_within(@eps).of(should_be), "#{result} != #{should_be} for #{rpc.correct_float_value} - #{opc.correct_float_value}")
       end
    end
  end

  it "has all logic operators that work" do
    @dataset.each do
       |rpct|
       expect((rpc = Mext::Music::PitchClass.new(rpct.float_value))).not_to be nil
       @dataset.each do
         |opct|
         expect((opc = Mext::Music::PitchClass.new(opct.float_value))).not_to be nil
         logic = rpct.freq <=> opct.freq
         @logic_operators.each do
           |l, v, val|
           expect(rpc.send(l, opc)).to(be(logic.send(v, val)), "#{rpct.correct_float_value} #{l} #{opct.correct_float_value}")
         end
         expect(rpc <=> opc).to(be(logic), "#{rpct.correct_float_value} <=> #{opct.correct_float_value}")
       end
    end
  end

  it 'has an :interval method that works' do
    @dataset.each do
      |rpct|
      expect((rpc = Mext::Music::PitchClass.new(rpct.float_value))).not_to be nil
      @dataset.each do
        |opct|
        expect((opc = Mext::Music::PitchClass.new(opct.float_value))).not_to be nil
        should_be = opct.semitones - rpct.semitones
        expect((result = rpc.interval(opc))).to(be_within(@eps).of(should_be), "#{result} != #{should_be} for #{rpc.to_f}.interval(#{opc.to_f})")
      end
    end
  end

  it 'has a :to_semitones method that works' do
    sz = @dataset.size
    @dataset.each do
       |pct|
       expect((mpc = Mext::Music::PitchClass.new(pct.float_value))).not_to be nil
       expect((bpc = Mext::Music::PitchClass.new(pct.octave, pct.semi))).not_to be nil
       expect((mresult = mpc.to_semitones)).to(be_within(@eps).of(pct.semitones), "pct.to_semitones #{mresult} != #{pct.semitones} for #{mpc.to_f}.to_semitones")
       expect((bresult = bpc.to_semitones)).to(be_within(@eps).of(pct.semitones), "pct.to_semitones #{bresult} != #{pct.semitones} for #{bpc.to_f}.to_semitones")
    end
  end

  it 'has a :transpose method that works' do
    sz = @dataset.size
    @dataset.each do
       |rpct|
       -60.upto(60).each do
         |semi|
         expect((mpc = Mext::Music::PitchClass.new(rpct.correct_float_value))).not_to be nil
         should_be = mpc + Mext::Music::PitchClass.new(0.0 + semi/100.0)
         result = mpc.transpose(semi)
         expect(result.to_f).to(be_within(@eps).of(should_be.to_f), "#{result.to_f} != #{should_be.to_f} for #{mpc.to_f}.transpose(#{semi})")
       end
    end
  end

end
