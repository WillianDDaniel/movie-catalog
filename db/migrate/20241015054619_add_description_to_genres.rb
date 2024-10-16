class AddDescriptionToGenres < ActiveRecord::Migration[7.1]
  def change
    add_column :genres, :description, :string
  end
end
