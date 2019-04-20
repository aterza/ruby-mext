require "ruby/mext/version"

module Ruby
  module Mext

    PATH = File.expand_path(File.join('..', 'mext'), __FILE__)

  end
end

%w(
  numeric
).each { |f| require File.join(Ruby::Mext::PATH, f) }
