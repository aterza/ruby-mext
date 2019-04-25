class MethodedHash < Hash

  def initialize(h = {})
    duplicate_hash(h)
    self
  end

  def []=(key, value)
    common_methodizer(key)
    super
  end

private

  def duplicate_hash(arg)
    arg.each do
      |k, v|
      self[k] = arg[k].dup
      #
      # we want to replicate MethodedHashes all along but we cannot use the
      # self.class.new(...) construct because it may create a subclass and
      # the result might not be what we want. So we define a protected class
      # method that will force-create a MethodedHash class (and that can be
      # overridden when needed)
      #
      self[k] = self.class.create(v) if v.kind_of?(Hash)
    end
  end

  def common_methodizer(k)
    methodize(k)
  end

  def methodize(key)
    nk = normalize_key(key)
    define_singleton_method(nk) { self[key] }
  end

  def normalize_key(key)
    ek = key.to_s.gsub(/\W/, '_')
    ek.to_sym
  end

protected

  class << self

    #
    # +create(h = {})+
    #
    # +create+ force-creates a MethodedHash class, avoiding potential
    # conflicts with children classes. However it can be overridden by
    # children classes if needed.
    #
    def create(h = {})
      MethodedHash.new(h)
    end

  end

end
