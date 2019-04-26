class Numeric

  #
  # +rrand(upper = 0)+: random number generator
  #
  # returns a random number in the range receiver-upper bound
  # 
  # If any of the numbers (the receiver +or+ the argument) are +Float+s
  # the method will return a +Float+. If both arguments are integers then an
  # +Integer+ will be returned.
  #
  # (this method is present in the SuperCollider sclang interpreter)
  #
  #:nodoc:

  def rrand(upper = 0.0)
    lobound = self.to_f
    rng = upper.to_f - lobound

    (rand()*rng) + lobound
  end

end

class Integer

  def rrand(upper = 0)
    res = super(upper)
    upper.is_a?(Integer) ? res.round : res
  end

end
