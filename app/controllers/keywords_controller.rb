# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    keywords = current_user.keywords
    keyword_presenters = keywords.map { |keyword| KeywordPresenter.new(keyword) }

    render locals: {
      keyword_presenter: keyword_presenters
    }
  end

  def create
    if keywords_parse_csv
      flash[:notice] = I18n.t('csv.upload_success')
    else
      flash[:alert] = keywords_form.errors.full_messages.first
    end

    redirect_to keywords_path
  end

  private

  def keywords_form
    @keywords_form ||= KeywordsForm.new(current_user)
  end

  def keywords_parse_csv
    keywords_form.save(params[:keyword][:keywords_file])
  end
end
