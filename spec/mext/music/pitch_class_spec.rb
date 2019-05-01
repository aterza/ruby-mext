require "spec_helper"

describe Mext::Music::PitchClass do

  before :example do
    @eps = 1e-6
    @dataset = [[8.00, 8, 0, 261.6255653005986, 12.077075066930124, 2.07, false, 55, 96],
                [0.0, 0, 0, 1.0219748644554634, 8.000674945903265, 8.00, false, 96, 0],
                [8.0925, 8, 9.25, 446.39994737250896, 8.092895890616193, 8.092103202004056, true, -105.25, 105.25],
                [8.55, 12, 7, 6271.926975707998, 12.081903188634497, 12.057217577480637, true, -45.75, 151],
    ]
    @instance_methods = [:to_f, :to_freq, :+, :-, :interval]
    @logic_operators = [:>, :>=, :<, :<=, :<=>, :==, :!=]
    @class_methods = [:new, :from_freq]
  end

  it 'can be created with a float' do
    @dataset.each do
      |args|
      expect(Mext::Music::PitchClass.new(args[0])).not_to be nil
    end
  end

  it 'passes all the pitch class dataset tests' do
    @dataset.each do
       |args|
       expect((pc = Mext::Music::PitchClass.new(args[0]))).not_to be nil
       expect((result = pc.octave)).to(eq(args[1]), "#{result} != #{args[1]} for #{args[0]}")
       expect((result = pc.semi)).to(be_within(@eps).of(args[2]), "#{result} != #{args[2]} for #{args[0]}")
       expect((result = pc.to_freq)).to(be_within(@eps).of(args[3]), "#{result} != #{args[3]} for #{args[0]}")
    end
  end

  it 'has all the methods we are looking for' do
    expect((pc = Mext::Music::PitchClass.new(@dataset.first[0]))).not_to be nil
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
       |args|
       (pc, oct, semi, freq) = args
       expect((mpc = Mext::Music::PitchClass.from_freq(freq))).not_to be nil
       expect((result = mpc.to_freq)).to(be_within(@eps).of(freq), "#{result} != #{freq} for #{mpc.to_f}")
    end
  end

  it 'has a :+ method that works' do
    sz = @dataset.size
    @dataset.each_index do
       |idx|
       args = @dataset[idx]
       other_idx = (idx + (sz-1)) % sz
       other_args = @dataset[other_idx]
       (pc, oct, semi, freq, sum) = args
       (opc, ooct, osemi, ofreq) = other_args
       expect((mpc = Mext::Music::PitchClass.new(pc))).not_to be nil
       expect((ompc = Mext::Music::PitchClass.new(opc))).not_to be nil
       expect((smpc = mpc + ompc)).not_to be nil
       expect((result = smpc.to_f)).to(be_within(@eps).of(sum), "#{result} != #{sum} for #{mpc.to_f} + #{ompc.to_f}")
    end
  end

  it 'has a :- method that works' do
    sz = @dataset.size
    @dataset.each_index do
       |idx|
       args = @dataset[idx]
       other_idx = (idx + (sz-1)) % sz
       other_args = @dataset[other_idx]
       (pc, oct, semi, freq, sum, sub) = args
       (opc, ooct, osemi, ofreq) = other_args
       expect((pcpc = Mext::Music::PitchClass.new(pc))).not_to be nil
       expect((opcpc = Mext::Music::PitchClass.new(opc))).not_to be nil
       if (freq - ofreq) < 0.0
         expect { pcpc - opcpc }.to raise_error(Mext::NegativeNumeric)
       else
         expect((smpcpc = pcpc - opcpc)).not_to be nil
         expect((result = smpcpc.to_f)).to(be_within(@eps).of(sub), "#{result} != #{sub} for #{pcpc.to_f} - #{opcpc.to_f}")
       end
    end
  end

  it "has all logic operators that work" do
    sz = @dataset.size
    @dataset.each_index do
       |idx|
       args = @dataset[idx]
       other_idx = (idx + (sz-1)) % sz
       other_args = @dataset[other_idx]
       (pc, oct, semi, freq, sum, sub, logic) = args
       (opc, ooct, osemi, ofreq) = other_args
       expect((mpc = Mext::Music::PitchClass.new(pc))).not_to be nil
       expect((ompc = Mext::Music::PitchClass.new(opc))).not_to be nil
       expect(mpc > ompc).to be logic
       expect(mpc < ompc).to be !logic
       expect(mpc >= ompc).to be logic
       expect(mpc <= ompc).to be !logic
       expect(mpc == ompc).to be false
       expect(mpc != ompc).to be true
       expect(mpc <=> ompc).to be (logic ? 1 : -1)
    end
  end

  it 'has an :interval method that works' do
    sz = @dataset.size
    @dataset.each_index do
       |idx|
       args = @dataset[idx]
       other_idx = (idx + (sz-1)) % sz
       other_args = @dataset[other_idx]
       (pc, oct, semi, freq, sum, sub, logic, intv) = args
       (opc, ooct, osemi, ofreq) = other_args
       expect((mpc = Mext::Music::PitchClass.new(pc))).not_to be nil
       expect((ompc = Mext::Music::PitchClass.new(opc))).not_to be nil
       expect((result = mpc.interval(ompc))).to(be_within(@eps).of(intv), "#{result} != #{intv} for #{mpc.to_f}.interval(#{ompc.to_f})")
    end
  end

  it 'has a :semitones method that works' do
    sz = @dataset.size
    @dataset.each_index do
       |idx|
       args = @dataset[idx]
       (pc, oct, semi, freq, sum, sub, logic, intv, semi) = args
       expect((mpc = Mext::Music::PitchClass.new(pc))).not_to be nil
       expect((result = mpc.to_semitones)).to(be_within(@eps).of(semi), "#{result} != #{semi} for #{mpc.to_f}.to_semitones")
    end
  end

end
