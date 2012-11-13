class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :active_docs
      t.integer :readers
      t.float :monthly_cost
      t.boolean :active

      t.timestamps
    end
  end
end
