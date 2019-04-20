class Numeric

  #
  # +mtof+: MIDI note to frequency converter
  #
  # interprets its receiver as a MIDI note and returns its frequency in Hertz
  #
  def mtof
    self.class.pitch_fork * (2.0**((self - MIDI_PITCH_FORK)/12.0))
  end

end
