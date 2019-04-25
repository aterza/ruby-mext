require 'version'

module Mext

  ROOT = File.expand_path(File.join('..'), __FILE__)

end

%w(
  ruby
  mext
).each { |f| require File.join(Mext::ROOT, f) }
