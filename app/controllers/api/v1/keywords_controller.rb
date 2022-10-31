# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      def index
        render(json: {
                 data: current_user
               })
      end

      def create
        if keywords_parse_csv
          render json: success_response, status: :created
        else
          render(json: {
                   message: keywords_form.errors.full_messages.first
                 })
        end
      end

      private

      def keywords_form
        @keywords_form ||= KeywordsForm.new(current_user)
      end

      def keywords_parse_csv
        keywords_form.save(params[:keywords_file])
      end

      def success_response
        {
          message: I18n.t('csv.upload_success')
        }
      end
    end
  end
end
