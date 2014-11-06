require 'spec_helper'

describe Ingredient do

  describe 'Raw ingredients' do
    xit 'can be normalized.' do
      i = Ingredient.new
      i.raw_measurement = "tb"
      expect(i.measurement).to eq("tablespoon")
    end
  end

end
