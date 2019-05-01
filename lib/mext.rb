module Mext

  PATH = File.expand_path(File.join('..', 'mext'), __FILE__)

end

%w(
  exceptions
  numeric
  array
  math
  music
).each { |f| require File.join(Mext::PATH, f) }
