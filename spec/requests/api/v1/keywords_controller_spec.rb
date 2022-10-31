# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::KeywordsController, type: :request do
  context 'given an unauthenticated user' do
    it 'returns a 401' do
      get :index

      expect(response.status).to eq(401)
    end
  end

  context 'given a valid CSV' do
    it 'returns a success response' do
      create_token_header

      post :create, params: keywords_file_params('valid.csv')

      expect(response).to have_http_status(:created)
    end
  end
end