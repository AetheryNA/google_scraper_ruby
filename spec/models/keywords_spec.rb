# frozen_string_literal: true

RSpec.describe Keyword, type: :model do
  describe '#update_status' do
    context 'given status is failed' do
      it 'updates the status' do
        keyword = Fabricate(:keyword)

        keyword.update_status(:failed)

        expect(keyword.status).to eq('failed')
      end
    end

    context 'given the status is completed' do
      it 'updates the status' do
        keyword = Fabricate(:keyword)

        keyword.update_status(:completed)

        expect(keyword.status).to eq('completed')
      end
    end

    context 'given the status is in progress' do
      it 'updates the status' do
        keyword = Fabricate(:keyword)

        keyword.update_status(:in_progress)

        expect(keyword.status).to eq('in_progress')
      end
    end
  end
end
