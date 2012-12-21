class ChangeUserCreditsToCreditDollars < ActiveRecord::Migration
  def up
    remove_column :users, :credit
    add_column :users, :credit_dollars, :integer, :default => 0
  end

  def down
    remove_column :users, :credit_dollars
    add_column :users, :credit, :integer
  end
end
