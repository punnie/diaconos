class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :day

      t.timestamps
    end
  end
end
