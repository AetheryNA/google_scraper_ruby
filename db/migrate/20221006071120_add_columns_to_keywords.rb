class AddColumnsToKeywords < ActiveRecord::Migration[7.0]
  def change
    add_column :keywords, :ads_top_count, :integer
    add_column :keywords, :ads_page_count, :integer
    add_column :keywords, :non_ads_count, :integer
    add_column :keywords, :total_links_count, :integer
    add_column :keywords, :html, :text
  end
end
