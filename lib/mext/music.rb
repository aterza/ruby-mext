module Mext

  MUSIC_PATH = File.join(Mext::PATH, 'music')

end

%w(
  pitch_class
).each { |f| require File.join(Mext::MUSIC_PATH, f) }
