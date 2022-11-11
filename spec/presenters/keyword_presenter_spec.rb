# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordPresenter, type: :presenters do
  describe '#name' do
    it 'returns the name of the keyword' do
      presenter = described_class.new(Fabricate(:keyword))

      expect(presenter.name).to eq(presenter.keyword.keyword)
    end
  end

  describe '#created at' do
    it 'returns the date at which the keyword was created' do
      presenter = described_class.new(Fabricate(:keyword))

      expect(presenter.created_at).to eq(presenter.keyword.created_at.strftime('%F %H:%M:%S'))
    end
  end
end
