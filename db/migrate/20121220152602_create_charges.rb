class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
    t.integer    :user_id
    t.integer    :document_id
    t.string     :stripe_charge_id
    t.integer    :amount,          :default => 0
    t.integer    :amount_refunded, :default => 0
    t.integer    :stripe_fee
    t.string     :failure_message
    t.integer    :amount_refunded, :default => 0
    t.boolean    :paid,            :default => false
    t.boolean    :refunded,        :default => false
    t.string     :coupon

    t.timestamps
    end
  end
end
