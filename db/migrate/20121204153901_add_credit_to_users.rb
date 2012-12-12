class AddCreditToUsers < ActiveRecord::Migration
  def up
    add_column :users, :credit, :integer, :default => 0
  end

  def down
    remove_column :users, :credit
  end
end
