require 'fileutils'
require File.expand_path(File.join(['..'] * 4, 'spec', 'fixtures', 'line_dataset'), __FILE__)
require File.expand_path(File.join('..', 'gruff_plot'), __FILE__)

namespace :plot do

  desc 'plot the Line dataset'
  task :line => :create_output_dir do
    ranges = [ Range.new(0, 0), Range.new(1,1) ]
    p = Mext::Gruff::Plotter.new('line_dataset', 800, Mext::Spec::Fixtures::Math::LINE_DATASETS, ranges)
    p.plot do
      |args|
      (ys, ye, xs, xe, xmid, ymid) = args
      Math::Line.new(ys, ye, xs, xe)
    end
  end

end
