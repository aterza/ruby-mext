module Math
  GOLDEN_PROPORTION = (sqrt(5.0)+1.0)/2.0
end

class Numeric

  #
  # +gold(power = 1.0)+: golden section ruler
  #
  # returns the value of the golden section elevated to the power of
  # +power+
  #
  #:nodoc:

  def gold(p = 1.0)
    self * (Math::GOLDEN_PROPORTION**(p))
  end

end
