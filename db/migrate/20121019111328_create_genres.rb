class CreateGenres < ActiveRecord::Migration
  def change
    create_table :genres do |t|
      t.string :genre

      t.timestamps
    end

    genres = %w[ fantasy mystery poetry romance technical ]
    genres.each do |g|
      Genre.create(:genre => g)
    end
  end
end
