module Mext

  PATH = File.expand_path(File.join('..', 'mext'), __FILE__)

end

%w(
  numeric
  math
).each { |f| require File.join(Mext::PATH, f) }
