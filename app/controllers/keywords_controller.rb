# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    results = keywords_query.call
    keywords_presenter = results.map { |keyword| KeywordPresenter.new(keyword) }

    render locals: {
      keywords_presenter: keywords_presenter
    }
  end

  def create
    if keywords_parse_csv
      DistributeSearchKeywordJob.perform_later(keywords_form.insert_keywords)

      flash[:notice] = I18n.t('csv.upload_success')
    else
      flash[:alert] = keywords_form.errors.full_messages.first
    end

    redirect_to keywords_path
  end

  def show
    keyword = current_user.keywords.find_by(id: params[:id])
    presenter = KeywordPresenter.new(keyword)

    render locals: {
      presenter: presenter
    }
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
    params.permit([:keyword, :url, :link_type])
  end
end
