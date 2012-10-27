class CreateParagraphRatings < ActiveRecord::Migration
  def change
    create_table :paragraph_ratings do |t|
      t.integer :paragraph_id
      t.integer :user_id
      t.hstore  :ratings, :default => {}

      t.timestamps
    end
  end
end
