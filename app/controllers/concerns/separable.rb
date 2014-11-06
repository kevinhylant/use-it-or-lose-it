require 'active_support/core_ext/string/inflections'

module Separable

  def self.to_array(csvs)
    csvs.split(/\s*,\s*/)
  end

end