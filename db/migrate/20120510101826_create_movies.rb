class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title,      null: false
      t.text :cast_members
      t.string :director
      t.string :genres
      t.integer :length
      t.string :mpaa_rating
      t.string :poster
      t.float :rating
      t.integer :rating_votes
      t.date :release_date
      t.string :tagline
      t.string :trailer
      t.integer :year
      t.integer :imdb_id,   null: false

      t.references :event
      t.integer :vote_count, default: 1

      t.timestamps
    end

    add_index :movies, :imdb_id
    add_index :movies, :event_id
  end
end
