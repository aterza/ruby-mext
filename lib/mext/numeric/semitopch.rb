class Numeric

  #:doc:
  #
  # +semitopch+: semitone to pitch class converter
  #
  # interprets its receiver as a semitone quantity (starting from 0 at
  # pitch class 0.00) and returns its corresponing pitch class
  #
  #:nodoc:

  def semitopch

    oct  = (self / CNPO).to_i
    semi = self - (oct * CNPO)
    semi %= CNPO
    semi = (self >= 0.0) ? semi : -((CNPO - semi) % CNPO)

    oct + (semi / PCC)

  end

end
