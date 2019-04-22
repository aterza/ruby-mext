module Mext

  NUMERIC_PATH = File.join(Mext::PATH, 'numeric')

end

%w(
  exceptions
  pitch_fork
  mtof
  ftom
  ampdb
  dbamp
  pchtom
  mtopch
  cpspch
).each { |f| require File.join(Mext::NUMERIC_PATH, f) }
