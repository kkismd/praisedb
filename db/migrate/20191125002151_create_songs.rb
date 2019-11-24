class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.references :organization, foreign_key: true
      t.string :code, null: false
      t.string :title, null: false
      t.text :words, null: false
      t.text :words_for_search, null: false
      t.string :cright, null: false
      t.timestamp :discarded_at

      t.timestamps
    end
    add_index :songs, :discarded_at
  end
end
