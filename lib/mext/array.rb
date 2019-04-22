module Mext

  ARRAY_PATH = File.join(Mext::PATH, 'array')

end

%w(
  choose
).each { |f| require File.join(Mext::ARRAY_PATH, f) }
