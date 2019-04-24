require "spec_helper"
require 'line_dataset'

describe Math::Line do

  before :example do
    @eps = 1e-6
    @arg_sets = Mext::Spec::Fixtures::Math::LINE_DATASETS
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

end

