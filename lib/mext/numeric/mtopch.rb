class Numeric

  #:doc:
  #
  # +mtopch+: MIDI note to pitch class converter
  #
  # interprets its receiver as a MIDI note and returns its corresponing pitch class
  #
  #:nodoc:

  def mtopch

    semi = (self - ZMP) / CNPO  
    oct  = semi.to_i
    semi = (semi - oct) * CNPO
    semi %= CNPO
    semi = (self > ZMP) ? semi : -((CNPO - semi) % CNPO)

    oct + (semi / PCC)

  end

end
