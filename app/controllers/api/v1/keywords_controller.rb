# frozen_string_literal: true

module Api
  module V1
    class KeywordsController < ApplicationController
      include ::Pagy::Backend
      include Api::V1::Pagy::JsonapiConcern

      def index
        pagy, keywords_list = pagy_array(keywords_query.call.map { |keyword| KeywordPresenter.new(keyword) })

        options = pagy_options(pagy)

        options[:meta] = options[:meta].merge(url_match_count: keywords_query.count_matching_urls)

        render json: KeywordSerializer.new(keywords_list, options)
      end

      def create
        if keywords_parse_csv
          DistributeSearchKeywordJob.perform_later(keywords_form.insert_keywords)

          render json: { message: I18n.t('csv.upload_success') }, status: :created
        else
          render json: { message: keywords_form.errors.full_messages.first }
        end
      end

      def show
        keyword = current_user.keywords.find show_params[:id]

        render json: KeywordSerializer.new(keyword, include: [:links], params: { show: true })
      end

      private

      def keywords_form
        @keywords_form ||= KeywordsForm.new(current_user)
      end

      def keywords_parse_csv
        keywords_form.save(params[:keywords_file])
      end

      def keywords_query
        @keywords_query ||= KeywordsQuery.new(current_user.keywords, indexable_params)
      end

      def indexable_params
        params.permit(%i[keyword url])
      end

      def show_params
        params.permit(:id)
      end
    end
  end
end
