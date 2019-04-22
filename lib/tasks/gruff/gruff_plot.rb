require 'gruff'

module Mext
  module Gruff

    class Plotter
      attr_reader :title, :size, :datasets, :ranges

      OUTPUT_PATH = File.expand_path(File.join(['..'] * 4, 'tmp', 'output'), __FILE__)

      def initialize(t, s, ds, r = nil)
        @title = t
        @size = s
        @datasets = ds
        @ranges = r
      end

      def plot
        @ranges = [Range.new(0, self.datasets-1)] unless self.ranges
        idx = 0
        self.ranges.each do
          |range|
          g = ::Gruff::Line.new(self.size)
          g.title = self.title + " (#{idx})"
          self.datasets[range].each do
            |args|
            (ys, ye, xs, xe, tau, xmid, ymid) = args
            f = Math::Expon.new(ys, ye, xs, xe, tau)
            (xdata, ydata) = f.xy(0.1)
            g.dataxy("tau: #{f.tau}", xdata, ydata)
          end
          g.write(File.join(Mext::Gruff::Plotter::OUTPUT_PATH, self.title.gsub(/\s+/, '_') + "_#{idx}.png"))
          idx += 1
        end
      end

    end
  end
end
