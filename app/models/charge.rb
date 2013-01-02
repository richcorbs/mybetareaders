class Charge < ActiveRecord::Base
  attr_accessible :amount, :amount_refunded, :user_id, :document_id, :failure_message, :paid, :refunded, :stripe_charge_id, :stripe_fee, :credit_applied, :coupon

  belongs_to :user
  belongs_to :document

  def self.new_for_free_document(document, current_user)
    Charge.create(
      :amount => 0,
      :amount_refunded => 0,
      :user_id => current_user.id,
      :document_id => document.id,
      :paid => 0,
      :refunded => 0,
      :stripe_fee => 0)
  end

  def self.new_from_stripe_charge(document_id, stripe_charge, current_user, coupon)
    Charge.create(
      :amount => stripe_charge.amount,
      :amount_refunded => stripe_charge.amount_refunded,
      :user_id => current_user.id,
      :document_id => document_id,
      :failure_message => stripe_charge.failure_message,
      :paid => stripe_charge.paid,
      :refunded => stripe_charge.refunded,
      :stripe_charge_id => stripe_charge.id,
      :stripe_fee => stripe_charge.fee)
  end

end
