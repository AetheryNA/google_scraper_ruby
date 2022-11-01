# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      def create
        if keywords_parse_csv
          render json: { message: I18n.t('csv.upload') }, status: :created
        else
          render json: { message: keywords_form.errors.full_messages.first }
        end
      end

      private

      def keywords_form
        @keywords_form ||= KeywordsForm.new(current_user)
      end

      def keywords_parse_csv
        keywords_form.save(params[:keywords_file])
      end
    end
  end
end
