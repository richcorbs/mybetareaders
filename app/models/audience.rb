class Audience < ActiveRecord::Base
  attr_accessible :audience

  has_many :documents
end
