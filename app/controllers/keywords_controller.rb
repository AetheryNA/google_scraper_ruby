# frozen_string_literal: true

class KeywordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @keywords = Keyword.all
    @keyword = Keyword.new
  end

  def create
    keywords_parse_csv
  end

  private

  def keywords_form
    @keyword_form = KeywordsForm.new(current_user)
  end

  def keywords_parse_csv
    keywords_form.save(params[:keyword][:keywords_file])
  end
end
