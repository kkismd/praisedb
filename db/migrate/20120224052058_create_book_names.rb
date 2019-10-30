class CreateBookNames < ActiveRecord::Migration[6.0]
  def change
    create_table :book_names do |t|
      t.integer :testament, null: false
      t.string :japanese, null: false
      t.string :english, null: false
    end
  end
end
