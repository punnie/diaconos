class AddUtilityFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :confirmed
      t.string :single_access_token
      t.string :persistance_token
    end
  end
end
