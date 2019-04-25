
module Mext
  module Ruby
    module Extensions

      PATH = File.expand_path(File.join('..', 'extensions'), __FILE__)

    end
  end
end

%w(
  methoded_hash
).each { |f| require File.join(Mext::Ruby::Extensions::PATH, f) }
