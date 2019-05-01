module Mext
  module Music

    class PitchClass
  
      attr_reader :octave, :semi
  
      #
      # +Mext::Music::PitchClass.new(float_value):
      #
      # pitch class object, where argument is:
      #
      # +float_value+: a pitch class in float notation (i.e. 8.00 for middle C, etc.)
      #
      #:nodoc:
      def initialize(fv)
        setup(fv)
      end
  
      #:doc:
      #
      # +to_f+
      #
      # returns the +pitch class+ in float notation
      #
      #:nodoc:
      def to_f
        #
        # we suppose here that the pitch_class data is well-formed inside the
        # object
        #
        self.octave + (self.semi / 100.0)
      end
  
      #:doc:
      #
      # +to_freq+
      #
      # returns the +pitch class+ in frequency (Hz)
      #
      #:nodoc:
      def to_freq
        self.to_f.pchcps
      end
  
      #:doc:
      #
      # all logical operators
      # 
      #
      #:nodoc:
      [:>, :>=, :<, :<=, :<=>, :==, :!=, :=== ].each do
        |op|
        define_method(op) { |other| self.to_freq.send(op, other.to_freq) }
      end

      #:doc:
      #
      # +\+(other)+ (operator plus)
      #
      # sums two pitch classes
      # 
      #
      #:nodoc:
      def +(other)
        PitchClass.new((self.to_freq + other.to_freq).cpspch)
      end

      #:doc:
      #
      # +-(other)+ (operator minus)
      #
      # subtracts two pitch classes
      # 
      #
      #:nodoc:
      def -(other)
        PitchClass.new((self.to_freq - other.to_freq).cpspch)
      end

      #:doc:
      #
      # +to_semitones+
      #
      # returns the +PitchClass+ to a number of semitones
      #
      def to_semitones
        (self.octave * 12.0) + self.semi
      end
  
      #:doc:
      #
      # +interval(other)+
      #
      # computes the interval among two pitch classes (in
      # number of semitones and fractions thereof)
      #
      #:nodoc:
      def interval(other)
        other.to_semitones - self.to_semitones
      end

      class << self
  
        #:doc:
        #
        # +from_freq+
        #
        # returns a +pitch class+ object from a frequency (Hz)
        #
        #:nodoc:
        def from_freq(f)
          new(f.cpspch)
        end

      end
  
    private
  
      def setup(fval)
        @octave = fval.floor
        s = (fval-@octave) * 100.0
        @octave += (s/12.0).floor
        @semi = s % 12.0
      end
  
    end

  end
end
