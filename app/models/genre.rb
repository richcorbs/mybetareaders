class Genre < ActiveRecord::Base
  attr_accessible :genre

  has_many :documents
end
