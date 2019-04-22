require 'cmath'

module Math

  class Expon

    attr_reader :y_start, :y_end, :x_start, :x_end, :tau
    attr_reader :a, :b, :c

    #
    # +DEFAULT_TAU+: default exponential curvature factor for +expon()+
    #
    DEFAULT_TAU = 0.01

    #
    # +Math::Expon.new(ystart, yend, xstart, xend, tau = DEFAULT_TAU)+:
    #
    # exponential curve `y = e^(a*x + b) + c` where:
    #
    # `c = yend + tau`
    #
    # Arguments are:
    #
    # +ystart+, +yend+: start/end y values required
    # +xstart+, +xend+: start/end x values
    # +tau+: the curvature factor
    #
    #:nodoc:
    def initialize(ys, ye, xs, xe, tau = DEFAULT_TAU)
      @y_start = ys
      @y_end   = ye
      @x_start = xs
      @x_end   = xe
      @tau     = tau
      setup
    end

    #:doc:
    #
    # +y(x)+:
    #
    # Returns a real value (forcing any complex result to its modulus) for any
    # given x
    #
    #:nodoc:
    def y(x)
      (CMath::exp(self.a*x + self.b) + self.c).abs   # we want a real number result, no complex please
    end

    #:doc:
    #
    # +xy(step)+
    #
    # Returns a full deployment of the function evaluated with a step of
    # +step+. It is returned in two arrays - one for the +x+ values and the
    # other for the +y+ values.
    #
    # This method is mainly for testing purposes with the dataxy method of +gruff+ 
    #
    #:nodoc:
    def xy(s)
      resx = []
      resy = []
      self.x_start.step(x_end, s) do
        |x|
        resx << x
        resy << self.y(x)
      end
      [resx, resy]
    end

  private

    def setup
       @c = self.y_end + self.tau

       exp_sv = self.y_start - self.c        # start value of the exponential
       exp_ev = self.y_end - self.c          # end value of the exponential
       x_length = self.x_end - self.x_start

       @a = (CMath::log(exp_ev) - CMath::log(exp_sv)) / x_length;
       @b= CMath::log(exp_sv) - (self.a * x_start);

    end

  end

end
