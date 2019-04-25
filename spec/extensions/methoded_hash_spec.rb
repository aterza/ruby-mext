require 'spec_helper'

RSpec.describe MethodedHash do

  before :example do
    @args = { 'one' => 1, 'two' => 2, 'three' => 3 }
    @weird_keys = { 'w? 1!' => 'w__1_', 'w/\^&2' => 'w____2', 'w$@:"|;.3' => 'w_______3' }
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
  
end
