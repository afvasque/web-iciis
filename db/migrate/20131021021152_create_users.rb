class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :login
      t.text :email
      t.text :crypted_password
      t.text :salt
      t.integer :role_id

      t.timestamps
    end
  end
end
