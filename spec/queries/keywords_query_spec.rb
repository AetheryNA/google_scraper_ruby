# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsQuery, type: :query do
  describe '#call' do
    context 'given a user with no keywords' do
      it 'returns an empty selection' do
        query = described_class.new(Fabricate(:user).keywords, {})

        expect(query.call).to be_empty
      end
    end

    context 'given a user with 3 keywords' do
      it 'returns 3 keywords' do
        user = Fabricate(:user)
        Fabricate.times(3, :keyword, user: user)

        query = described_class.new(user.keywords, {})

        expect(query.call.length).to eq(3)
      end
    end

    context 'given a user with keywords and a word to query' do
      it 'returns the keyword with relevance to the search' do
        user = Fabricate(:user)

        %w[Random Genshin Honkai].each { |name| Fabricate(:keyword, user: user, keyword: name) }

        query = described_class.new(user.keywords, { keyword: 'gens', url: '' })

        expect(query.call.map(&:keyword)).to eq(%w[Genshin])
      end
    end
  end
end
