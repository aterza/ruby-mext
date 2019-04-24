class Numeric

  #
  # +ftom+: frequency converter to MIDI note
  #
  # interprets its receiver as a frequency and returns its corresponing MIDI note
  #

  def ftom
    raise Mext::NegativeNumeric if self < 0.0
    MIDI_PITCH_FORK + (12.0*Math::log2(self/self.class.pitch_fork))
  end

end
