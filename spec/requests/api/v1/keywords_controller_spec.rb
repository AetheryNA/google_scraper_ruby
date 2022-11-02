# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::KeywordsController, type: :request do
  context 'given an authenticated user' do
    it 'returns the keywords' do
      user = Fabricate(:user)
      Fabricate.times(10, :keyword, user: user)

      create_token_header(user)

      get :index

      expect(json_response[:data].count).to eq(10)
    end

    it 'does not display the HTML attribute' do
      user = Fabricate(:user)
      Fabricate.times(10, :keyword, user: user)

      create_token_header(user)

      get :index

      expect(json_response[:data].first[:attributes].keys).not_to include(:html)
    end

    it 'does not include any additional data such as the result_links' do
      user = Fabricate(:user)
      Fabricate.times(10, :keyword, user: user)

      create_token_header(user)

      get :index

      expect(json_response[:included]).to be_nil
    end
  end

  context 'given multiple pages of keywords' do
    it 'returns the first page of keywords' do
      user = Fabricate(:user)
      Fabricate.times(31, :keyword, user: user)

      create_token_header(user)

      get :index

      expect(json_response[:data].count).to eq(30)
    end

    it 'returns the total_pages meta info' do
      user = Fabricate(:user)
      Fabricate.times(31, :keyword, user: user)

      create_token_header(user)

      get :index

      expect(json_response[:meta][:total_pages]).to eq(2)
    end
  end

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
