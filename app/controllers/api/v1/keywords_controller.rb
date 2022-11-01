# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      def index
        render json: KeywordSerializer.new(current_user.keywords)
      end

      def create
        if keywords_parse_csv
          DistributeSearchKeywordJob.perform_later(keywords_form.insert_keywords)

          render json: { message: I18n.t('csv.upload_success') }, status: :created
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
