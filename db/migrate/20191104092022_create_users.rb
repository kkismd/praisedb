class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.references :home, foreign_key: true
      t.string :name
      t.string :password_digest
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
