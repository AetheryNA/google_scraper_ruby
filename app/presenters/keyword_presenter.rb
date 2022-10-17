# frozen_string_literal: true

class KeywordPresenter
  attr_reader :keyword

  def initialize(keyword)
    @keyword = keyword
  end

  def name
    keyword.keyword
  end

  def created_at
    keyword.created_at.strftime('%F %H:%M:%S')
  end
end
