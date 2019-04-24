require 'fileutils'
require File.expand_path(File.join(['..'] * 4, 'spec', 'fixtures', 'expon_dataset'), __FILE__)
require File.expand_path(File.join('..', 'gruff_plot'), __FILE__)

namespace :plot do

  desc 'plot the Expon dataset'
  task :expon => :create_output_dir do
    ranges = [ Range.new(0, 2), Range.new(3,3) ]
    p = Mext::Gruff::Plotter.new('expon_dataset', 800, Mext::Spec::Fixtures::Math::EXPON_DATASETS, ranges)
    p.plot do
      |args|
      (ys, ye, xs, xe, tau, xmid, ymid) = args
      Math::Expon.new(ys, ye, xs, xe, tau)
    end
  end

end
