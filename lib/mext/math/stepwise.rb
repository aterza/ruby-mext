module Math

  class Stepwise < Function

    class Point
      attr_reader :x, :y

      def initialize(x, y)
        @x = x
        @y = y
      end
    end

    #
    # +:values+
    #
    # is an array of pairs (+x+, +y+)
    #
    attr_reader :values

    #
    # +Math::Stepwise.new(values = [])+
    #
    # stepwise function
    #
    # Arguments are:
    #
    # +values+:         an array of (+x+, +y+) pairs
    #
    #:nodoc:
    def initialize(vs = [])
      setup(vs)
    end

    #:doc:
    #
    # +y(x)+:
    #
    # Returns a value for any given x
    #
    #:nodoc:
    def y(x)
      lookup(x)
    end

    def label
      'stepwise function'
    end

    class << self

      #
      # +from_yaml(yaml_hash)+:
      #
      # creates a Math::Stepwise class from a yaml file which must have the
      # relevant fields:
      #
      # +values+: an array of duples [x, y]
      #
      def from_yaml(yh)
        new(yh['values'])
      end

    end

  private

    def lookup(x)
      last = nil
      self.values.each do
        |p|
        break if p.x > x
        last = p.y
      end
      last
    end

    #
    # +setup+
    #
    # setup basically sorts the input array in time creating points
    #
    #:nodoc:
    def setup(vs)
      @values = []
      sorted = vs.sort { |a, b| a[0] <=> b[0] }
      sorted.each { |duple| self.values << Point.new(duple[0], duple[1]) }
      #
      # keep in mind that vs might be empty
      #
      @x_start = self.values.first ? self.values.first.x : self.values.first
      @x_end   = self.values.last ? self.values.last.x : self.values.last
    end

  end

end

