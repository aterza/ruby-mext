require 'spec_helper'
require 'yaml'

RSpec.describe MethodedHash do

  before :example do
    @args = { 'one' => 1, 'two' => 2, 'three' => 3 }
    @weird_keys = { 'w? 1!' => 'w__1_', 'w/\^&2' => 'w____2', 'w$@:"|;.3' => 'w_______3' }
    @nested_keys = { :a => { :b => { 'c' => { :d => 0, 'e' => 1, :f => 2 }}}}
    @mh_metafile = File.expand_path(File.join(['..'] * 2, 'fixtures', 'methoded_hash_stuff.yml'), __FILE__)
  end

  it 'can be created without arguments' do
    expect((m = MethodedHash.new)).not_to be nil
  end
  
  it 'can be created with arguments' do
    expect((m = MethodedHash.new(@args))).not_to be nil
  end
  
  it 'works as a normal hash' do
    expect((m = MethodedHash.new(@args))).not_to be nil
    @args.keys { |k| expect(m[k]).to eq(@args[k]) }
  end
  
  it 'works as a methoded hash' do
    expect((m = MethodedHash.new(@args))).not_to be nil
    @args.keys.each { |k| expect(m.send(k.to_sym)).to eq(@args[k]) }
  end
  
  it 'works as a methoded hash even with weird keys' do
    expect((m = MethodedHash.new(@weird_keys))).not_to be nil
    @weird_keys.each { |k, v| expect(m.send(v.to_sym)).to eq(@weird_keys[k]) }
  end

  def check_nested_values(mh, parent)
    expect(mh.kind_of?(MethodedHash)).to be true
    mh.each do
      |key, value|
      expect(mh.respond_to?(key)).to(be(true), key.to_s)
      if value.kind_of?(Hash)
        check_nested_values(value, mh)
      else
        expect(mh.send(key)).to(eq(value), "mh.send('#{key}') != #{value} (it is #{mh.send(key)} instead)")
      end
      if parent
        expect(parent.respond_to?(key)).to(be(false), "key #{key} got mixed up into the parent")
      end
    end
  end

  it 'creates methoded hashes iteratively' do
    expect(m = MethodedHash.new(@nested_keys)).not_to be nil
    check_nested_values(m, nil)
  end

  #
  # We need to check that this works even when it is subclassed
  #
  class Child < MethodedHash

    def initialize(mf)
      super(YAML.load(File.open(mf, 'r')))
    end

  end

  it 'works even when subclassed' do
    expect(m = Child.new(@mh_metafile)).not_to be nil
    expect(m.kind_of?(MethodedHash)).to be true
    expect(m.kind_of?(Hash)).to be true
    check_nested_values(m, nil)
  end
  
end
