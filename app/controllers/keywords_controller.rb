# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @keywords = Keyword.all
    @keyword = Keyword.new
  end

  def create
    if keywords_parse_csv
      # find_keyword = Keyword.find(keywords_form.insert_keywords)

      # google_search_service(find_keyword[0].keyword).call

      SearchKeywordsJob.perform_later(keywords_form.insert_keywords)

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
