class AddPasswordToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :password_encrypted
      t.string :password_salt
    end
  end
end
