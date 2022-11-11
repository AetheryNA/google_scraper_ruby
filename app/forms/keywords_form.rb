# frozen_string_literal: true

require 'csv'

class KeywordsForm
  include ActiveModel::Model

  validates_with KeywordsFormValidator

  attr_accessor :file, :user, :keywords

  def initialize(user)
    @user = user
  end

  def save(params)
    assign_attributes(params)

    return false if invalid?

    begin
      if parse_keywords(params[:file])
        Keyword.transaction do
          Keyword.create(parse_keywords_from_file(keywords)).pluck(:id)
        end
      end
    rescue ActiveRecord::ActiveRecordError => e
      errors.add("Error: #{e}")
    end

    errors.empty?
  end

  private

  def parse_keywords_from_file(keyword_records)
    keyword_records.compact_blank.map do |keyword|
      {
        user_id: user.id,
        keyword: keyword
      }
    end
  end

  def parse_keywords(file)
    csv_data = CSV.read(file)
    assign_attributes(keywords: csv_data.map(&:first).compact_blank)
  end
end
