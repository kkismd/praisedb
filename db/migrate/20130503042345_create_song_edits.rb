class CreateSongEdits < ActiveRecord::Migration[6.0]
  def change
    create_table :song_edits do |t|
      t.references :song, foreign_key: true
      t.text :words, null: false

      t.timestamps
    end
  end
end
