class Numeric

  #
  # +ampdb+: linear to dB converter
  #
  # interprets its receiver as a linear value and returns it in dB
  #
  def ampdb
    raise Mext::NegativeNumeric if self < 0.0
    20*Math::log10(self)
  end

end
