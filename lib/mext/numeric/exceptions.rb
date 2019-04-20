class Numeric

  #
  # +NegativeNumeric+ is raised on certain operations that do not allow
  # negative arguments or receivers
  #
  class NegativeNumeric < StandardError; end

end
