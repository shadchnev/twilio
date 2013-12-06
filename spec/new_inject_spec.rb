require 'new_inject'


describe 'new_inject ' do

  context 'inheritance' do

    it 'should be of class type Array' do
      expect(Array.instance_methods.include?(:new_inject)).to be_true
    end

  end

  context 'it should take an optional argument' do

    it 'should return one for no argument, called on [1]' do
      answer = [1].new_inject() {|a,b| a = b; a }
      expect(answer).to eq(1)
    end

    it 'should return [1,2] with [1] as arg, called on [2]' do
      answer = [2].new_inject([1]) {|a,b| a << b; a}
      expect(answer).to eq([1,2])
    end

    it 'the optional argument cannot be longer than 1' do
      expect{[1].new_inject(1,2)}.to raise_error(RuntimeError)
    end

  end

end
