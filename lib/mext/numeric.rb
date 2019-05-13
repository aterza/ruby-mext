module Mext
  module Numeric

    PATH = File.join(Mext::PATH, 'numeric')
    VECTORIZABLE_METHODS = %w(
      cround
      mtof
      ftom
      ampdb
      dbamp
      pchtom
      mtopch
      pchtosemi
      semitopch
      cpspch
      pchcps
      gold
      rrand
      mmtot
    )
    NON_VECTORIZABLE_METHODS = %w(
      constants
      pitch_fork
    )
    ADDED_METHODS = NON_VECTORIZABLE_METHODS + VECTORIZABLE_METHODS

  end
end

Mext::Numeric::ADDED_METHODS.each { |f| require File.join(Mext::Numeric::PATH, f) }
