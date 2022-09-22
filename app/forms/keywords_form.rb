#frozen_string_literal: true

require 'csv'

class KeywordsForm
  include ActiveModel::Model

  attr_reader :file
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def save(csv_file)
    @file = csv_file

    puts parse_keywords

    parse_keywords.each do |keyword|
      Keyword.insert({
        users_id: user.id,
        keywords: keyword,
        created_at: Time.current,
        updated_at: Time.current
      })
    end
  end

  private

  def parse_keywords
    csv_data = CSV.read(file)
    csv_data.map(&:first)
  end
end
