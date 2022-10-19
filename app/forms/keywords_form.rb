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
      if parse_keywords_from_file
        save_keywords_to_db(parse_keywords_from_file)
      end
    rescue ActiveRecord::ActiveRecordError => error
      errors.add("Error: #{error}")
    end

    errors.empty?
  end

  private

  def parse_keywords_from_file
    parse_keywords.map { |keyword| add_keyword_record(keyword) }
  end

  def save_keywords_to_db(keyword_records)
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
