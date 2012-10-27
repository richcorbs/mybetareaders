class CreateDoctypes < ActiveRecord::Migration
  def change
    create_table :doctypes do |t|
      t.string :doctype

      t.timestamps
    end
    types = %w[novel technical short_story blog_post excerpt]
    types.each do |t|
      Doctype.create(:doctype => t)
    end
  end
end
