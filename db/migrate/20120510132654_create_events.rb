class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :day
      t.string :status, default: "unspoken"

      t.timestamps
    end
  end
end
