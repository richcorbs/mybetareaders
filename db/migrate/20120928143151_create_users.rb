class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :email
      t.string  :password_hash
      t.string  :password_salt
      t.string  :auth_token
      t.hstore  :reading_preferences
      t.integer :plan_id
      t.boolean :admin

      t.timestamps
    end

    user = User.new({:email => 'rich.corbridge@gmail.com', :password => "richard"})
    user.admin = true
    user.save
    user = User.new({:email => 'jaimetheler@gmail.com', :password => "jaime"})
    user.admin = true
    user.save

    execute "CREATE INDEX users_gin_reading_preferences ON users USING GIN(reading_preferences)"
  end
end
