module Mext
  module Ruby

    PATH = File.expand_path(File.join('..', 'ruby'), __FILE__)

  end
end

%w(
  extensions
).each { |f| require File.join(Mext::Ruby::PATH, f) }
