class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.references :folder, foreign_key: true
      t.integer :position, null: false
      t.string :title, null: false
      t.string :action_name, null: false
      t.string :controller_name, null: false
      t.text :params_value, null: false

      t.timestamps
    end
  end
end
