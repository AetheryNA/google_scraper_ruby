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

    return false if invalid?

    begin
      save_keywords_to_db
    rescue ActiveRecord::ActiveRecordError
      errors.add('Invalid File')
    end

    errors.empty?
  end

  private

  def save_keywords_to_db
    keyword_records = parse_keywords.map { |keyword| add_keyword_record(keyword) }

    SaveKeywordsToDb.new(keyword_records).call
  end

  def parse_keywords
    csv_data = CSV.read(file)
    csv_data.map(&:first)
  end

  def add_keyword_record(keyword)
    return nil if keyword.blank?

    {
      user_id: user.id,
      keyword: keyword
    }
  end
end
