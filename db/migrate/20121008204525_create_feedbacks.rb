class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer  :user_id
      t.integer  :document_id
      t.integer  :reader_rating, :default => 0
      t.boolean  :accepted_by_user
      t.integer  :bookmark
      t.boolean  :reader_feedback_complete

      t.timestamps
    end
  end
end
