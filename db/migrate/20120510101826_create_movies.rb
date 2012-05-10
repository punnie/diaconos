class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :cast_members
      t.string :title
      t.string :director
      t.string :genres
      t.integer :length
      t.string :mpaa_rating
      t.string :poster
      t.float :rating
      t.date :release_date
      t.string :tagline
      t.string :trailer
      t.integer :votes
      t.integer :year
      t.integer :imdb_id

      t.timestamps
    end

    add_index :movies, :imdb_id
  end
end
