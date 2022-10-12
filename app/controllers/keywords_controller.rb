# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    keywords = current_user.keywords

    render locals: {
      keywords: keywords
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
end
