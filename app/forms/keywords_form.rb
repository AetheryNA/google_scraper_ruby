# frozen_string_literal: true

require 'csv'

class KeywordsForm
  include ActiveModel::Model

  validates_with KeywordsFormValidator

  attr_reader :file, :user

  def initialize(user)
    @user = user
  end

  def save(csv_file)
    @file = csv_file

    begin
      keyword_records = parse_keywords.map { |keyword| add_keyword_record(keyword) }

      # rubocop:disable Rails::SkipsModelValidations
      @keyword_ids = Keyword.insert_all(keyword_records).map { |keyword| keyword['id'] }
      # rubocop:enable Rails::SkipsModelValidations
    rescue ActiveRecord::ActiveRecordError
      errors.add(keywords.upload)
    end

    errors.empty?
  end

  private

  def parse_keywords
    csv_data = CSV.read(file)
    csv_data.map(&:first)
  end

  def add_keyword_record(keyword)
    return nil if keyword.blank?

    {
      users_id: user.id,
      keywords: keyword,
      created_at: Time.current,
      updated_at: Time.current
    }
  end
end
