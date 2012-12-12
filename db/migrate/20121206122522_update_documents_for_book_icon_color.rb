class UpdateDocumentsForBookIconColor < ActiveRecord::Migration
  def up
    add_column :documents, :book_icon_color, :string
    remove_column :documents, :book_binding_color
    remove_column :documents, :book_jacket_color
  end

  def down
    remove_column :documents, :book_icon_color
  end
end
