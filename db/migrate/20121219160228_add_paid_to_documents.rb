class AddPaidToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :paid, :boolean
  end
end
