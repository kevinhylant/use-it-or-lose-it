class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  @@raw_abnormals = ['box','pinch','tsps','jar','large','container','package', 'ea', 'sm', 'medium', 'can', 'bag', 'Tbs', '-inch', 'envelope', 'stalks']
  @@abnormals = []

  def to_ounces  
    create_ignored_list(@@raw_abnormals)
    if !has_nil_or_zero_measurement? && !has_nil_or_zero_quantity? && !has_abnormal_measurment?
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

  def has_abnormal_measurment?
    @@abnormals.include? (measurement)
  end

  def is_weight?(obj)
    weight_types = ['lb','oz']
    weight_types.include?(obj)
  end

  def is_volume?(obj)
    vol_types = ['gal','qt','pt','c.','fl. oz.','tbsp.','tsp.']
    vol_types.include?(obj)
  end

  def create_ignored_list(ary)
    ary.each do |term|
      @@abnormals << term
      @@abnormals << term.pluralize
    end
  end
end


