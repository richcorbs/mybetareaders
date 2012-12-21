class Coupon < ActiveRecord::Base
  attr_accessible :active, :amount, :code, :percent
end
