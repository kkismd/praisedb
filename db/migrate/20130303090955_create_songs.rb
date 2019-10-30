class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :code, null: false
      t.string :title, null: false
      t.text :words, null: false
      t.text :words_for_search, null: false
      t.string :cright, null: false
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end
