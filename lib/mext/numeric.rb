module Mext

  NUMERIC_PATH = File.join(Mext::PATH, 'numeric')

end

%w(
  pitch_fork
  mtof
  ftom
  ampdb
  dbamp
  pchtom
  mtopch
  cpspch
  pchcps
  rrand
  gold
).each { |f| require File.join(Mext::NUMERIC_PATH, f) }
