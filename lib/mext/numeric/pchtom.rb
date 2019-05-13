class Numeric

  #
  # +pchtom+: pitch class to MIDI note converter
  #
  # interprets its receiver as a pitch class and returns its corresponing MIDI note
  #
  #:nodoc:

  def pchtom
    self.pchtosemi + ZMP
  end

end
