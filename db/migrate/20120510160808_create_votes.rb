class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :movie
      t.string :direction

      t.timestamps
    end
    add_index :votes, :user_id
    add_index :votes, :movie_id
  end
end
