class CreateAudiences < ActiveRecord::Migration
  def change
    create_table :audiences do |t|
      t.string :audience

      t.timestamps
    end
    audiences = %w[ elementary middle_grade young_adult adult ]
    audiences.each do |a|
      Audience.create(:audience => a)
    end
  end
end
