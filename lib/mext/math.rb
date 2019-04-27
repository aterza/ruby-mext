module Mext

  MATH_PATH = File.join(Mext::PATH, 'math')

end

%w(
  function
  line
  expon
  stepwise
).each { |f| require File.join(Mext::MATH_PATH, f) }
