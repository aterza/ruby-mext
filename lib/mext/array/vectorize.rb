class Array

  #
  # +vectorization+:
  #
  # extend any +Mext::Numeric+ operation to a vector of values
  # (a la Matlab/Octave)
  #
  #:nodoc:
  Mext::Numeric::VECTORIZABLE_METHODS.each do
    |m|
    msym = m.to_sym
    define_method(msym) { |*args| common_vectorizer(msym, args) }
  end

private

  def common_vectorizer(meth, args)
    self.map { |val| args.empty? ? val.send(meth) : val.send(meth, *args) }
  end

end
