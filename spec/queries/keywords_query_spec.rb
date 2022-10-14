# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsQuery, type: :query do
  context 'given empty keywords list and no filter' do
    it 'returns an empty keywords list' do
      user = Fabricate(:user)

      keyword_query = described_class.new(user.keywords, {})

      keyword_query.call

      expect(keyword_query.keywords).to be_empty
    end
  end

  context 'given a keywords list' do
    it 'returns a keyword' do
      user = Fabricate(:user)

      (1.day.ago.to_date..Time.zone.today).each_with_index { |date, index| Fabricate(:keyword, id: index, user: user, created_at: date) }
      keyword_query = described_class.new(user.keywords, {})

      keyword_query.call

      expect(keyword_query.keywords.map(&:id)).to eq([0, 1])
    end
  end
end
