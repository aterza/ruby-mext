class Array

  #
  # +choose+: choose a random element in the array
  #
  # returns a random element from the array
  #
  #:nodoc:

  def choose
    idx = (rand()*(self.size-1)).round
    self[idx]
  end

end
