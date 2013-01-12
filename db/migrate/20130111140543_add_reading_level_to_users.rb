class AddReadingLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reading_level, :string
  end
end
