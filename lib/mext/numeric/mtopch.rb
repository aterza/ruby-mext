class Numeric

  #
  # +mtopch+: MIDI note to pitch class converter
  #
  # interprets its receiver as a MIDI note and returns its corresponing pitch class
  #
  #:nodoc:

  def mtopch

    intv = (self - MIDI_MIDDLE_C) / CHROMATIC_NOTES_PER_OCTAVE

    intv_octave = intv.to_i
    intv_semi = (intv - intv_octave) * CHROMATIC_NOTES_PER_OCTAVE;

    PITCH_MIDDLE_C + intv_octave + (intv_semi/100.0);
  end

end
