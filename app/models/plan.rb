class Plan < ActiveRecord::Base
  attr_accessible :active, :active_docs, :monthly_cost, :name, :readers
end
