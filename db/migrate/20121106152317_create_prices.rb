class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.string  :name
      t.integer :words_min
      t.integer :words_max
      t.float   :cost
      t.boolean :active

      t.timestamps
    end
  end
end
