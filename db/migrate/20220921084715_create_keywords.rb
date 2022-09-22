class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :keywords, null: false
      t.integer :status, null: false, default: 0
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
