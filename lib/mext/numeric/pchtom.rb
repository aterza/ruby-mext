class Numeric

  #
  # +pchtom+: pitch class to MIDI note converter
  #
  # interprets its receiver as a pitch class and returns its corresponing MIDI note
  #
  #:nodoc:
  MIDI_MIDDLE_C = 60

  def pchtom
    p_octave = self.to_i
    p_note = (self - p_octave) * 100

    p_octave += (p_note / 12.0).to_i # cater for octave wrapping
    p_note   = (p_note % 12.0);      # reduce note in a 0-11 space

    m_octave = ((p_octave - 8.0)*12) + 60; # find the appropriate midi octave

    m_octave + p_note
  end

end
