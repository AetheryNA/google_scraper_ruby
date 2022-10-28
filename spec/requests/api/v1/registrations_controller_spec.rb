# frozen_string_literal: true

require 'rails_helper'

describe Api::V1::RegistrationsController, type: :request do
  context 'when a user registers' do
    context 'given valid params' do
      it 'returns the user' do
        post :create, params: create_user_params.merge(email: 'testemail@email.com'), format: :json

        expect(response).to have_http_status(:success)
      end
    end
  end
end
