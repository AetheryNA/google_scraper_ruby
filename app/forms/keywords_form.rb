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

    return false unless valid?

    begin
      keyword_records = parse_keywords.map { |keyword| add_keyword_record(keyword) }

      # rubocop:disable Rails::SkipsModelValidations
      @insert_keywords = Keyword.insert_all(keyword_records).map { |keyword| keyword['id'] }
      # rubocop:enable Rails::SkipsModelValidations
    rescue ActiveRecord::ActiveRecordError
      errors.add('Error')
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
      user_id: user.id,
      keyword: keyword,
      created_at: Time.current,
      updated_at: Time.current
    }
  end
end
