module Mext
  module Spec
    module Fixtures
      PATH = File.expand_path(File.join('..', 'fixtures'), __FILE__)
    end
  end
end

$LOAD_PATH.unshift Mext::Spec::Fixtures::PATH
$LOAD_PATH.unshift File.expand_path(File.join(['..'] * 2, 'lib'), __FILE__)
require 'byebug'

require 'ruby-mext'
