require 'gruff'
require 'byebug'

module Mext
  module Gruff

    class Plotter
      attr_reader :title, :size, :datasets, :ranges
      attr_accessor :step, :dot_radius

      OUTPUT_PATH = File.expand_path(File.join(['..'] * 4, 'tmp', 'output'), __FILE__)
      DEFAULT_STEP = 0.1
      DEFAULT_DOT_RADIUS = 2.0

      def initialize(t, s, ds, r = nil, stp = DEFAULT_STEP)
        @title = t
        @size = s
        @datasets = ds
        @ranges = r
        self.step = stp
        self.dot_radius = DEFAULT_DOT_RADIUS
      end

      def plot
        @ranges = [Range.new(0, self.datasets-1)] unless self.ranges
        idx = 0
        self.ranges.each do
          |range|
          g = ::Gruff::Line.new(self.size)
          g.title = self.title + " (#{idx})"
          g.theme = ::Gruff::Themes::PASTEL
          g.dot_radius = self.dot_radius
          self.datasets[range].each do
            |args|
            f = yield(args)
            (xdata, ydata) = f.xy(self.step)
            g.dataxy(f.label, xdata, ydata)
          end
          g.write(File.join(Mext::Gruff::Plotter::OUTPUT_PATH, self.title.gsub(/\s+/, '_') + "_#{idx}.png"))
          idx += 1
        end
      end

    end

  end
end
