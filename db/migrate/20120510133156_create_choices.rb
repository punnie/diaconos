class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references :movie
      t.references :event
      t.integer :votes, default: 1

      t.timestamps
    end
    add_index :choices, :movie_id
    add_index :choices, :event_id
  end
end
