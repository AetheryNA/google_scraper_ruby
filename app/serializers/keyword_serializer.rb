# frozen_string_literal: true

class KeywordSerializer
  include JSONAPI::Serializer

  attributes :keyword, :created_at, :updated_at, :status, :ads_top_count, :ads_page_count, :non_ads_count,
             :total_links_count

  attribute :html, if: proc { |_, params| params[:show] }

  has_many :result_links, if: proc { |_, params| params[:show] }
end
