class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.integer :version, null: false
      t.references :book_name, foreign_key: true
      t.integer :chapter, null: false
      t.integer :verse, null: false
      t.text :word, null: false
    end
  end
end
