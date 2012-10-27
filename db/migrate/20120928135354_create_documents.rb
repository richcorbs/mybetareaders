class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string  :title
      t.integer :user_id
      t.string  :doctype
      t.string  :description
      t.string  :book_jacket_color
      t.string  :book_binding_color
      t.integer :audience_id
      t.integer :genre_id
      t.date    :deadline
      t.boolean :fiction

      t.timestamps
    end
  end
end
