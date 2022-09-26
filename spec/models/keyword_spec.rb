# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Keyword, type: :model do
  describe 'Update status' do
    it 'updates the keyword status to completed' do
      keyword = Fabricate(:keyword)
      keyword.update_status(:completed)

      expect(keyword.status).to eq('completed')
    end

    it 'updates the keyword status to fail' do
      keyword = Fabricate(:keyword)
      keyword.update_status(:failed)

      expect(keyword.status).to eq('failed')
    end
  end
end
