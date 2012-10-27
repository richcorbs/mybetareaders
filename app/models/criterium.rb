class Criterium < ActiveRecord::Base
  attr_accessible :criterium, :description, :fiction, :nonfiction

  def self.ordered_by_alpha
    Criterium.order(:criterium)
  end
end
