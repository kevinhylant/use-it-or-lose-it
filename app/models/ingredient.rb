class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  # before_save :normalize
  @@raw_ignores = ['box','pinch']
  @@ignores = []

  private
  def normalize
    create_ignored_list(@@raw_ignores)
    
    self.measurement= Measurement.parse(self.measurement) unless @@ignores.include?(self.measurement)
  end

  def create_ignored_list(ary)
    ary.each do |term|
      
      @@ignores << term
      @@ignores << term.pluralize
    end
  end

end


