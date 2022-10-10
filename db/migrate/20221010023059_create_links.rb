class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.references :keyword, foreign_key: true, null: false
      t.integer :link_type, null: false
      t.citext :url, null: false

      t.timestamps
    end
  end
end
