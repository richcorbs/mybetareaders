class ChangeCreditDollarsToCreditCentsInUsers < ActiveRecord::Migration
  def up
    remove_column :users, :credit_dollars
    add_column :users, :credit_cents, :integer, :default => 0
  end

  def down
    remove_column :users, :credit_cents
    add_column :users, :credit_dollars, :integer
  end
end
