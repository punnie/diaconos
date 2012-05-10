class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.boolean :admin, default: false

      t.timestamps
    end
  end
end
