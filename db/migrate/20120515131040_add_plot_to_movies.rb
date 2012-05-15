class AddPlotToMovies < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.text :plot
    end
  end
end
