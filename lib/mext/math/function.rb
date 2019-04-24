module Math

  class Function

    attr_reader :x_start, :x_end
    #
    # +Math::Function.new+:
    #
    # abstract base class function
    #
    #:nodoc:
    def initialize
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

    #:doc:
    #
    # +label+
    #
    # Returns a label which can be used in plots
    #
    def label
      ''
    end

  private

    def setup
      raise Mext::PureAbstractMethodCalled
    end

  end

end
