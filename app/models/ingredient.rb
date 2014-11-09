class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  @@normals = {
    'gal' => 'gallon',
    'qt' => 'quart',
    'pt' => 'pint',
    'c' => 'cup',
    'tb' => 'tablespoon',
    'tsp' => 'teaspoon',
    'oz' => 'ounce',
  }

  def to_ounces
    if !has_nil_or_zero_measurement? && !has_nil_or_zero_quantity? && has_normal_measurement?
      convert_to_long_form_normal_measurement
      parsed = Measurement.parse("#{self.quantity} #{self.measurement}")
      measurement_type = parsed.unit.to_s
      if is_weight?( measurement_type )
        parsed.convert_to(:oz)
      elsif is_volume?( measurement_type )
        parsed.convert_to(:'fl oz')
      end
    else
      ''
    end
  end

  def has_nil_or_zero_measurement?
    measurement == nil || measurement == 0
  end

  def has_nil_or_zero_quantity?
    quantity == nil || quantity == 0
  end

  def has_normal_measurement?
    m = measurement.singularize.downcase
    @@normals.keys.include?(m) || @@normals.values.include?(m)
  end

  def is_weight?(obj)
    weight_types = ['lb','oz']
    weight_types.include?(obj)
  end

  def is_volume?(obj)
    vol_types = ['gal','qt','pt','c.','fl. oz.','tbsp.','tsp.']
    vol_types.include?(obj)
  end

  def convert_to_long_form_normal_measurement
    m = self.measurement.singularize.downcase
    self.measurement= @@normals[self.measurement.singularize.downcase] if @@normals.keys.include?(m) 
  end

end
