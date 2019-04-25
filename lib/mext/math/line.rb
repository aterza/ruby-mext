module Math

  class Line < Function

    attr_reader :y_start, :y_end
    attr_reader :a, :b

    #
    # +Math::Line.new(ystart, yend, xstart, xend)+:
    #
    # linear interpolation `y = a*x + b` where:
    #
    # `a = (yend-ystart)/(xend-xstart)`
    # `b = ystart - (a*xstart)`
    #
    # Arguments are:
    #
    # +ystart+, +yend+: start/end y values required
    # +xstart+, +xend+: start/end x values
    #
    #:nodoc:
    def initialize(ys, ye, xs, xe)
      @y_start = ys.to_f
      @y_end   = ye.to_f
      @x_start = xs.to_f
      @x_end   = xe.to_f
      setup
    end

    #:doc:
    #
    # +y(x)+:
    #
    # Returns a real value given x
    #
    #:nodoc:
    def y(x)
      (self.a*x) + self.b
    end

    def label
      "a: #{self.a}\nb: #{self.b}"
    end

    class << self

      #
      # +from_yaml(yaml_hash)+:
      #
      # creates a Math::Line class from a yaml file which must have the
      # relevant fields:
      #
      # +x_start+
      # +x_end+
      # +y_start+
      # +y_end+
      #
      def from_yaml(yh)
        args = [yh['y_start'], yh['y_end'], yh['x_start'], yh['x_end']]
        new(*args)
      end

    end

  private

    def setup
      @a = (self.y_end - self.y_start)/(self.x_end - self.x_start)
      @b = (self.y_start - (self.x_start * self.a))
    end

  end

end

