class CreateSlides < ActiveRecord::Migration[6.0]
  def change
    create_table :slides do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.string :author, null: false
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :slides, :discarded_at
  end
end
