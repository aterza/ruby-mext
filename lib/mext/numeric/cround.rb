class Numeric

  #
  # +cround(eps = 1e-8)+: conditional rounding algorithm
  #
  # +cround+ will return a rounded number if the starting value is nearer to
  #          its nearest integer by less than +eps+. Otherwise it will not round
  #          the receiver
  #
  #:nodoc:
  DEFAULT_CROUND_EPS = 1e-8

  def cround(eps = DEFAULT_CROUND_EPS)
    rv = self.round
    ((self - rv).abs < eps) ? rv : self
  end

end
