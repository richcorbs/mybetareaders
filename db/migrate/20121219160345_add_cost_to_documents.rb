class AddCostToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :cost, :integer
  end
end
