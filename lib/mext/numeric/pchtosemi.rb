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
    p_octave = self.to_i
    p_note = (self - p_octave) * 100
    ref = self < 0.0 ? -CHROMATIC_NOTES_PER_OCTAVE : CHROMATIC_NOTES_PER_OCTAVE

    p_octave += (p_note / CHROMATIC_NOTES_PER_OCTAVE).to_i # cater for octave wrapping
    p_note   = (p_note % ref);                             # reduce note in a 0-11 space (keeping track of sign)

    (p_octave * CNPO) + p_note
  end

end
