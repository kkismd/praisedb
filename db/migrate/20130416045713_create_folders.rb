class CreateFolders < ActiveRecord::Migration[6.0]
  def change
    create_table :folders do |t|
      t.string :title, null: false
      t.boolean :sticky, null: false, default: false

      t.timestamps
    end
  end
end
