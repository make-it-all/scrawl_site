class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.string :auth_token
      t.string :encrypted_password
      t.string :confirmation_token
      t.string :remember_token

      t.timestamps
    end
  end
end
