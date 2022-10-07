class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.citext :url, null: false
      t.integer :link_type, null: false
      t.references :keyword, null: false, foreign_key: true

      t.timestamps
    end
  end
end
