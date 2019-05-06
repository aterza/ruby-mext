class Numeric

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

#   intv = self - MIDI_MIDDLE_C
#   intv /= CHROMATIC_NOTES_PER_OCTAVE

#   intv_octave = intv.floor
#   intv_semi = (intv_octave >= 0.0) ? (intv - intv_octave) : (1 - (intv_octave - intv))
#   
#   intv_semi *= CHROMATIC_NOTES_PER_OCTAVE;
#   intv_semi %= CHROMATIC_NOTES_PER_OCTAVE;

#   PITCH_MIDDLE_C + intv_octave + (intv_semi/100.0);

  end

end
