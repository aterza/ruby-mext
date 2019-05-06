class Numeric

  #
  # +pchtom+: pitch class to MIDI note converter
  #
  # interprets its receiver as a pitch class and returns its corresponing MIDI note
  #
  #:nodoc:

  def pchtom
    p_octave = self.to_i
    p_note = (self - p_octave) * 100
    ref = self < 0.0 ? -CHROMATIC_NOTES_PER_OCTAVE : CHROMATIC_NOTES_PER_OCTAVE

    p_octave += (p_note / CHROMATIC_NOTES_PER_OCTAVE).to_i # cater for octave wrapping
    p_note   = (p_note % ref);                             # reduce note in a 0-11 space (keeping track of sign)

    m_octave = ((p_octave - PITCH_MIDDLE_C)*CHROMATIC_NOTES_PER_OCTAVE) + MIDI_MIDDLE_C; # find the appropriate midi octave

    m_octave + p_note
  end

end
