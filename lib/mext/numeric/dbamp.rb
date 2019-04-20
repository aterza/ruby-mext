class Numeric

  #
  # +dbamp+: MIDI note to frequency converter
  #
  # interprets its receiver as dB and returns its linear value
  #
  def dbamp
    10.0**(self/20.0)
  end

end

