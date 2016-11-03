require 'spec_helper'

describe Spree::Calculator::FlatPercentOrderTotal, :type => :model do
  let(:calculator) { Spree::Calculator::FlatPercentOrderTotal.new }
  let(:order) do
    FactoryGirl.create(:order)
  end

  before { allow(calculator).to receive_messages preferred_flat_percent: 100 }

  context 'compute' do
    it 'should round result correctly' do
      expect(calculator.compute(order)).to eq order.calculated_total
    end

    it 'returns object.amount if computed amount is greater' do
      allow(calculator).to receive_messages preferred_flat_percent: 110
      expect(calculator.compute(order)).to eq order.total
    end
  end
end
