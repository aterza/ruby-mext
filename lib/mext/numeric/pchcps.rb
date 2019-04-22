class Numeric

  #
  # +pchcps+: pitch class converter to frequency
  #
  # interprets its receiver as pitch class and returns its corresponing frequency
  #
  #:nodoc:

  def pchcps
    m_note = self.pchtom

    m_note.mtof
  end

end
