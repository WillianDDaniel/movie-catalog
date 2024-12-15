class AddOriginalTitleToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :original_title, :string
  end
end
