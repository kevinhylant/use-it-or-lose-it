require 'spec_helper'

describe Order do
  let(:order) { create(:order) }
  let(:recipe) { create(:recipe, title: 'Pastum') }

  describe 'An order is properly associated' do
    xit 'to its recipes. Its recipe has a title.' do
      expect(order.recipes.first.title).to eq('Pastum')
    end
  end

end
