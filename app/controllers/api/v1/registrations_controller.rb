# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < ApplicationController
      skip_before_action :doorkeeper_authorize!, only: :create

      def create
        user = User.new(email: user_params[:email], password: user_params[:password])

        client_app = find_client_app(params[:client_id])

        return render(json: { error: 'Invalid client ID' }, status: :forbidden) unless client_app

        if user.save
          access_token = generate_access_token(user, client_app)

          render(:index, locals: { user: user, access_token: access_token })
        else
          render(json: { error: user.errors.full_messages }, status: :unprocessable_entity)
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def find_client_app(_client_id)
        Doorkeeper::Application.find_by(uid: params[:client_id])
      end

      def generate_access_token(user, client_app)
        # create access token for the user, so the user won't need to login again after registration
        Doorkeeper::AccessToken.create(
          resource_owner_id: user.id,
          application_id: client_app.id,
          refresh_token: generate_refresh_token,
          expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
          scopes: ''
        )
      end

      def generate_refresh_token
        loop do
          # generate a random token string and return it,
          # unless there is already another token with the same string
          token = SecureRandom.hex(32)
          break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
        end
      end
    end
  end
end
