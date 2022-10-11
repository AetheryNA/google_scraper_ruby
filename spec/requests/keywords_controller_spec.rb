# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsController, type: :request do
  describe 'GET #index' do
    it 'returns http success' do
      sign_in Fabricate(:user)
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    context 'given a valid id' do
      it 'returns http success' do
        keyword = Fabricate(:keyword)
        sign_in keyword.user
        get :show, params: { id: keyword.id }

        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        keyword = Fabricate(:keyword)
        sign_in keyword.user
        get :show, params: { id: keyword.id }

        expect(response).to render_template(:show)
      end
    end
  end
end
