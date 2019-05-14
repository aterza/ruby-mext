module Mext
  module Music

    class PitchClass
  
      attr_reader :octave, :semi
  
      #
      # +Mext::Music::PitchClass.new(float_value, semi = nil)+:
      #
      # pitch class object, where argument is:
      #
      # +float_value+: a pitch class in float notation (i.e. 8.00 for middle C, etc.)
      #                +or+ an octave value when given in octave, semi pair (see below)
      # +semi+: (optional) when this argument is not nil, then it is assumed
      #         that the first argument is the octave, and this one is the
      #         semitone value
      #
      #:nodoc:
      def initialize(fv, semi = nil)
        semi ? setup_with_two_arguments(fv, semi) : setup_with_one_argument(fv)
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
        self.octave + (self.semi / ::Numeric::PCC)
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
      #:nodoc:
      def +(other)
        octave = ((self.to_semitones + other.to_semitones) / 12.0).cround
        octave = octave >= 0.0 ? octave.floor : octave.ceil
        semis  = (self.to_semitones + other.to_semitones).cround % 12.0
        phase  = octave >= 0.0 ? 1 : -1
        PitchClass.new(octave, phase*semis)
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
        tot_semi = self.to_semitones - other.to_semitones
        PitchClass.new(0.0, tot_semi)
      end

      #:doc:
      #
      # +to_semitones+
      #
      # returns the +PitchClass+ to a number of semitones
      #
      def to_semitones
        self.to_f.pchtosemi
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

      #:doc:
      #
      # +transpose(semitones)+
      #
      # returns the transposition in semitones
      #
      #:nodoc:
      def transpose(semi)
        self + PitchClass.new(0.0, semi)
      end

      #:doc:
      #
      # +interval_proportion(prop, other)+:
      #
      # returns the interval proportion (in semitones) given
      #
      # - +prop+: a proportional factor (should be in the range 0-1)
      # - +other+: the other pitch
      #
      def interval_proportion(prop, other)
        self.interval(other) * prop
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

      def setup_with_one_semitone_argument(semival)
        setup_with_one_argument(semival.semitopch)
      end
  
      def setup_with_one_argument(fval)
        (o, s) = separate_oct_semi(fval)
        setup_with_two_arguments(o, s)
      end

      def separate_oct_semi(fval)
        octave = fval >= 0.0 ? fval.floor : fval.ceil
        s = (fval-octave) * ::Numeric::PCC
        [octave, s]
      end

      #
      # +setup_with_two_arguments(oct, semi)+:
      #
      # we must make sure that the two values are congruent, that is:
      # +oct+ is a float number and +semi+ is between 0..11.999999
      # taking into account that pitch classes can be positive or negative
      #
      def setup_with_two_arguments(oct, s)
        octsemi = (s / 12.0)
        octsemi = case
                  when octsemi > 0.0 then octsemi.floor
                  when octsemi < 0.0 then octsemi.ceil
                  when octsemi == 0.0 then 0.0
                  end
        oct += octsemi
        remainder = s >= 0.0 ? (s % 12.0) : (s % -12.0)
        @octave = oct
        @semi = remainder
        self
      end

    end

  end
end
