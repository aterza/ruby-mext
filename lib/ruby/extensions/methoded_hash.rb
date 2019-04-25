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
      self[k] = self.class.new(v) if v.kind_of?(Hash)
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

end
