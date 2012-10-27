class CreateParagraphComments < ActiveRecord::Migration
  def change
    create_table :paragraph_comments do |t|
      t.integer :paragraph_id
      t.integer :user_id
      t.text    :comment
      t.boolean :writer_flagged, :default => false

      t.timestamps
    end
  end
end
