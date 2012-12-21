class AddActiveToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :active, :boolean
  end
end
