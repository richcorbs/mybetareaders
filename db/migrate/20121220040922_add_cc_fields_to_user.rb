class AddCcFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_4_digits, :string
    add_column :users, :stripe_customer_id, :string
  end
end
