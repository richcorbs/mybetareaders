class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.integer  :user_id
      t.integer  :document_id
      t.boolean  :invited

      t.timestamps
    end
  end
end
