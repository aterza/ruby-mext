require "spec_helper"
require 'yaml'
require 'expon_dataset'

describe Math::Expon do

  before :example do
    @eps = 1e-6
    @arg_sets = Mext::Spec::Fixtures::Math::EXPON_DATASETS
    @yaml_data = YAML.load(File.open(File.join(Mext::Spec::Fixtures::PATH, 'expon.yml'), 'r'))
  end

  it 'can be created' do
    expect(Math::Expon.new(*@arg_sets[0][0..4])).not_to be nil
  end

  it 'passes all the expon dataset tests' do
    @arg_sets.each do
       |args|
       (ys, ye, xs, xe, tau, xmid, ymid) = args
       expect((fun = Math::Expon.new(ys, ye, xs, xe, tau))).not_to be nil
       expect((result = fun.y(xs))).to(be_within(@eps).of(ys), "#{result} != #{ys} for #{xs}")
       expect((result = fun.y(xe))).to(be_within(@eps).of(ye), "#{result} != #{ye} for #{xe}")
       expect((result = fun.y(xmid))).to(be_within(@eps).of(ymid), "#{result} != #{ymid} for #{xmid} (tau = #{fun.tau})")
    end
  end

  it 'can be created from an appropriate yaml file' do
    expect((fun = Math::Expon.from_yaml(@yaml_data))).not_to be nil
    args = @arg_sets.first
    (ys, ye, xs, xe, tau, xmid, ymid) = args
    expect((result = fun.y(xs))).to(be_within(@eps).of(ys), "#{result} != #{ys} for #{xs}")
    expect((result = fun.y(xe))).to(be_within(@eps).of(ye), "#{result} != #{ye} for #{xe}")
    expect((result = fun.y(xmid))).to(be_within(@eps).of(ymid), "#{result} != #{ymid} for #{xmid} (tau = #{fun.tau})")
  end

end
