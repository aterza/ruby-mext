class Numeric

  #:doc:
  #
  # +pchtosemi+: pitch class to semitones converter
  #
  # interprets its receiver as a pitch class and returns the
  # corresponding quantity in semitones
  #
  #:nodoc:

  def pchtosemi
    (p_octave, p_note) = self.pchtooctsemi

    (p_octave * CNPO) + p_note
  end

end
