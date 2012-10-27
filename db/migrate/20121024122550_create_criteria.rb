class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.string  :criterium
      t.text    :description
      t.boolean :fiction
      t.boolean :nonfiction

      t.timestamps
    end
    criteria = %w[ clarity interesting mechanics pace simple]
    criteria.each do |c|
      Criterium.create( :criterium => c, :fiction => true, :nonfiction => true )
    end
  end
end
