module Mext

  #
  # +NegativeNumeric+ is raised on certain operations that do not allow
  # negative arguments or receivers
  #
  class NegativeNumeric < StandardError; end

  #
  # +PureAbstractMethodCalled+ is raised when an abstract
  # base class is called
  #
  class PureAbstractMethodCalled < StandardError; end

end
