class AddCoverUrlToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :cover_url, :string
  end
end
