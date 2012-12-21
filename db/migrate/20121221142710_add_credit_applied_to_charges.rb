class AddCreditAppliedToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :credit_applied, :integer
  end
end
