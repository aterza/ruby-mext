require "spec_helper"
require 'yaml'
require 'stepwise_dataset'

describe Math::Stepwise do

  before :example do
    @eps = 1e-6
    @arg_sets = Mext::Spec::Fixtures::Math::STEPWISE_DATASETS
    @yaml_data = YAML.load(File.open(File.join(Mext::Spec::Fixtures::PATH, 'stepwise.yml'), 'r'))
    @step = 0.1
  end

  it 'can be created' do
    @arg_sets.each do
      |args|
      expect(Math::Stepwise.new(args)).not_to be nil
    end
  end

  it 'passes all the stepwise dataset tests' do
    @arg_sets.each do
       |args|
       unless args.empty?
         mid = (args.size/2.0).floor
         expect((fun = Math::Stepwise.new(args))).not_to be nil
         expect((result = fun.y(args[0][0]))).to(be_within(@eps).of(args[0][1]), "#{result} != #{args[0][1]} for #{args[0][0]}")
         expect((result = fun.y(args.last[0]))).to(be_within(@eps).of(args.last[1]), "#{result} != #{args.last[1]} for #{args.last[0]}")
         expect((result = fun.y(args[mid][0]))).to(be_within(@eps).of(args[mid][1]), "#{result} != #{args[mid][1]} for #{args[mid][0]}")
       end
    end
  end

  it 'can be created from an appropriate yaml file' do
    expect((fun = Math::Stepwise.from_yaml(@yaml_data))).not_to be nil
    args = @arg_sets.first
    mid = (args.size/2.0).floor
    expect((result = fun.y(args.first[0]))).to(be_within(@eps).of(args.first[1]), "#{result} != #{args.first[1]} for #{args.first[0]}")
    expect((result = fun.y(args.last[0]))).to(be_within(@eps).of(args.last[1]), "#{result} != #{args.last[1]} for #{args.last[0]}")
    expect((result = fun.y(args[mid][0]))).to(be_within(@eps).of(args[mid][1]), "#{result} != #{args[mid][1]} for #{args[mid][0]}")
  end

  it 'can handle the xy() method' do
    @arg_sets.each do
       |args|
       unless args.empty? || args.size == 1
         expect((fun = Math::Stepwise.new(args))).not_to be nil
         size_should_be = ((fun.x_end - fun.x_start) / @step.to_f).floor + 1
         expect((sz = fun.xy(@step)[0].size)).to(eq(size_should_be), "#{sz} != #{size_should_be} for #{args.to_s}")
       end
    end
  end


end
