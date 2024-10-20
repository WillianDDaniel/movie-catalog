class CreateGenreDescriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :genre_descriptions do |t|
      t.string :genre_name
      t.text :description

      t.timestamps
    end
  end
end
