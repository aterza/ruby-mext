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
    arg.keys.each { |k| self[k] = arg[k].dup }
  end

  def common_methodizer(k)
    self.class.methodize(k)
  end

  class << self

    def methodize(key)
      nk = normalize_key(key)
      define_method(nk) { self[key] }
    end
  
    def normalize_key(key)
      ek = key.to_s.gsub(/\W/, '_')
      ek.to_sym
    end

  end

end
