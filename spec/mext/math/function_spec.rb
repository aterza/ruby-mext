require "spec_helper"

describe Math::Function do

  it 'cannot be created (pure abstract class)' do
    expect { Math::Function.new }.to raise_error(Mext::PureAbstractMethodCalled)
  end
  
  it 'cannot be created (pure abstract class) even through the :from_yaml method' do
    expect { Math::Function.from_yaml(nil) }.to raise_error(Mext::PureAbstractMethodCalled)
  end
  

  #
  # fake concrete function
  #
  class FakeFunction < Math::Function

    private

      def setup
      end
  end

  it 'has a :xy method' do
    expect((f = FakeFunction.new)).not_to be nil
    expect(f.respond_to?(:xy)).to be true
  end

end
