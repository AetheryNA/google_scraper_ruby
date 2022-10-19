# frozen_string_literal: true

class SaveKeywordsToDb
  def initialize(keyword_records)
    @keyword_records = keyword_records
  end

  attr_reader :keyword_records

  def call
    # rubocop:disable Rails::SkipsModelValidations
    Keyword.create(keyword_records).map { |keyword| keyword['id'] }
    # rubocop:enable Rails::SkipsModelValidations
  end
end
