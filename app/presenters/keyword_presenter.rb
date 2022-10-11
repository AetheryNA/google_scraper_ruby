# frozen_string_literal: true

class KeywordPresenter
  def initialize(keyword)
    @keyword = keyword
  end

  attr_reader :keyword

  def name
    keyword.keyword
  end

  def created_at
    keyword.created_at.strftime('%F %H:%M:%S')
  end

  def raw_html
    keyword.html
  end

  def ads_top_urls
    keyword.links.filter_map { |link| link.url if link.link_type == 'ads_top' }
  end

  def non_ads_urls
    keyword.links.filter_map { |link| link.url if link.link_type == 'non_ads' }
  end

  def status
    return 'in progress' if keyword.in_progress?
    return 'completed' if keyword.completed?
    return 'failed' if keyword.failed?
  end
end
