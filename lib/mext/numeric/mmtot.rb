class Numeric

  #
  # +mm(subdivision = 1.0)+: metronome to time converter
  #
  # interprets its receiver as a metronome marking to time in seconds
  #
  # +subdivision+ the time subdivision
  #
  #:nodoc:
  SECONDS_PER_MINUTE = 60.0

  def mmtot(subdiv = 1.0)
    (SECONDS_PER_MINUTE*subdiv) / self
  end

end
