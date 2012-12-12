class Price < ActiveRecord::Base
  attr_accessible :active, :cost, :name, :words_max, :words_min
end
