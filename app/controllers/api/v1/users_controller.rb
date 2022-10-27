module API
  module V1
    class Api::V1::UsersController < ApplicationController
      skip_before_action :doorkeeper_authorize!

      def index
        puts 'test'

        render json: {
          data: 'hello there'
        }
      end

      def create
        user = User.new(create_params)

        if user.save
          render json: UserSerializer.new(user).serializable_hash, status: :created
        else
          render json: {
            details: user.errors.full_messages.to_sentence
          }
        end
      end

      private

      def create_params
        params.permit(:email, :password)
      end
    end
  end
end
