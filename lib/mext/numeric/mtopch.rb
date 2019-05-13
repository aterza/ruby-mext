class Numeric

  #:doc:
  #
  # +mtopch+: MIDI note to pitch class converter
  #
  # interprets its receiver as a MIDI note and returns its corresponing pitch class
  #
  #:nodoc:

  def mtopch

    (self - ZMP).semitopch

  end

end
