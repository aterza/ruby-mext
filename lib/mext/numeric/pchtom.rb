class Numeric

  #
  # +pchtom+: pitch class to MIDI note converter
  #
  # interprets its receiver as a pitch class and returns its corresponing MIDI note
  #
  #:nodoc:

  def pchtom
    (p_octave, p_note) = pchtocommon

    m_octave = ((p_octave - PITCH_MIDDLE_C)*CNPO) + MIDI_MIDDLE_C; # find the appropriate midi octave

    m_octave + p_note
  end

end
