require 'version'

module Mext

  ROOT = File.expand_path(File.join('..'), __FILE__)

end

%w(
  mext
).each { |f| require File.join(Mext::ROOT, f) }
