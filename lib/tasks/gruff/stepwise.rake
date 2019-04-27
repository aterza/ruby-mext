require 'fileutils'
require File.expand_path(File.join(['..'] * 4, 'spec', 'fixtures', 'stepwise_dataset'), __FILE__)
require File.expand_path(File.join('..', 'gruff_plot'), __FILE__)

require 'byebug'

namespace :plot do

  desc 'plot the Stepwise dataset'
  task :stepwise => :create_output_dir do
    ranges = [ Range.new(0, 1) ]
    p = Mext::Gruff::Plotter.new('stepwise_dataset', 800, Mext::Spec::Fixtures::Math::STEPWISE_DATASETS, ranges)
    p.plot do
      |args|
      Math::Stepwise.new(args)
    end
  end

end
