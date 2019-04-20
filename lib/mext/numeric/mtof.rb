class Numeric

  #
  # +mtof+: MIDI note to frequency converter
  #
  # interprets its receiver as a MIDI note and returns its frequency in Hertz
  #
  class NegativeNumeric < StandardError; end

  def mtof
    raise NegativeNumeric if self < 0.0
    self.class.pitch_fork * (2.0**((self - MIDI_PITCH_FORK)/12.0))
  end

end
