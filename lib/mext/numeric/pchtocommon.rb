class Numeric

private

  #:doc:
  #
  # +pchtocommon+: common private method to convert pitch classes
  # into something else
  #
  # interprets its receiver as a pitch class and returns the
  # corresponding separated note and semitones
  #
  #:nodoc:

  def pchtocommon
    p_octave = self.to_i
    p_note = (self - p_octave) * 100
    ref = self < 0.0 ? -CHROMATIC_NOTES_PER_OCTAVE : CHROMATIC_NOTES_PER_OCTAVE

    p_octave += (p_note / CHROMATIC_NOTES_PER_OCTAVE).to_i # cater for octave wrapping
    p_note   = (p_note % ref);                             # reduce note in a 0-11 space (keeping track of sign)

    [p_octave, p_note]
  end

end
