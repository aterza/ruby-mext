require "spec_helper"
require 'yaml'
require 'line_dataset'

describe Math::Line do

  before :example do
    @eps = 1e-6
    @arg_sets = Mext::Spec::Fixtures::Math::LINE_DATASETS
    @yaml_data = YAML.load(File.open(File.join(Mext::Spec::Fixtures::PATH, 'line.yml'), 'r'))
  end

  it 'can be created' do
    expect(Math::Line.new(*@arg_sets[0][0..3])).not_to be nil
  end

  it 'passes all the line dataset tests' do
    @arg_sets.each do
       |args|
       (ys, ye, xs, xe, xmid, ymid) = args
       expect((fun = Math::Line.new(ys, ye, xs, xe))).not_to be nil
       expect((result = fun.y(xs))).to(be_within(@eps).of(ys), "#{result} != #{ys} for #{xs}")
       expect((result = fun.y(xe))).to(be_within(@eps).of(ye), "#{result} != #{ye} for #{xe}")
       expect((result = fun.y(xmid))).to(be_within(@eps).of(ymid), "#{result} != #{ymid} for #{xmid}")
    end
  end

  it 'can be created from an appropriate yaml file' do
    expect((fun = Math::Line.from_yaml(@yaml_data))).not_to be nil
    args = @arg_sets.first
    (ys, ye, xs, xe, xmid, ymid) = args
    expect((result = fun.y(xs))).to(be_within(@eps).of(ys), "#{result} != #{ys} for #{xs}")
    expect((result = fun.y(xe))).to(be_within(@eps).of(ye), "#{result} != #{ye} for #{xe}")
    expect((result = fun.y(xmid))).to(be_within(@eps).of(ymid), "#{result} != #{ymid} for #{xmid}")
  end

end

