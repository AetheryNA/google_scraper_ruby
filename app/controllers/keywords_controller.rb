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
    keywords_form ||= KeywordsForm.new(user: current_user)

    if keywords_form.save({ file: keyword_params, user: current_user })
      flash[:notice] = t('csv.upload_success')
    else
      flash[:alert] = keywords_form.errors.full_messages.first
    end

    redirect_to keywords_path
  end

  private

  def keyword_params
    params.require(:keywords_file)
  end
end
