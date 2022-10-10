# frozen_string_literal: true

class GoogleParseService
  TOP_ADS_SELECTOR = '#tads > div'
  ADS_PAGE_COUNT_SELECTOR = '.pla-unit-container'
  TOP_ADS_URL_SELECTOR = '#tads > div a[data-ved]'
  NON_ADS_COUNT_SELECTOR = 'a[data-ved] > h3'

  def initialize(html:)
    @html = html
    @document = Nokogiri::HTML(html)
  end

  attr_reader :html, :document

  def ads_top_count
    @ads_top_count ||= document.css(TOP_ADS_SELECTOR).count
  end

  def ads_page_count
    ads_top_count + document.css(ADS_PAGE_COUNT_SELECTOR).count
  end

  def non_ads_count
    document.css(NON_ADS_COUNT_SELECTOR).count
  end

  def total_links_count
    document.css('a').count
  end

  def ads_top_urls
    document.css(TOP_ADS_URL_SELECTOR).map { |a_tag| a_tag['href'] }
  end

  def non_ads_urls
    document.css(NON_ADS_COUNT_SELECTOR).map { |h3_tag| h3_tag.parent['href'] }
  end

  def all_links
    ads_top_links = links(ads_top_urls, :ads_top)
    non_ads_links = links(non_ads_urls, :non_ads)
    ads_top_links + non_ads_links
  end

  def links(urls, type)
    urls.map do |url|
      {
        url: url,
        link_type: type
      }
    end
  end
end
