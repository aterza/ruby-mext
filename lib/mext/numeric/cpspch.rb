class Numeric

  #
  # +cpspch+: frequency to pitch class converter
  #
  # interprets its receiver as frequency and returns its corresponing pitch class
  #
  #:nodoc:

  def cpspch
    raise Mext::NegativeNumeric if self <= 0.0

    midi_note = self.ftom

    midi_note.mtopch
  end

end
