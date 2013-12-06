require 'takeaway'

describe Takeaway do

  let(:takeaway) {Takeaway.new('tom')}

  context 'has a list of takeaway dishes' do

    it 'should have a list of 5 takeaways ' do
      expect(takeaway.menu.length).to eq(5)
    end

    it 'should include PIZZA biatch' do
      expect(takeaway.menu.keys.include?(:Italian)).to be_true
    end

    it 'should cost £19.70 for Italian and Thai order' do
      expect(takeaway.total_cost(:Italian, :Thai)).to eq(19.70)
    end

    it 'should return Italian and Thai order list' do
      expect(takeaway.order(:Italian, :Thai)).to eq([:Italian, :Thai])
    end

    # it 'should text a brother their order' do
    #   order = double :order
    #   expect(takeaway).to receive(:send_text)
    #   takeaway.order(:Italian,:Thai)
    # end

  end

end