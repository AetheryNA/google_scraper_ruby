# frozen_string_literal: true

class GoogleSearchService
  BASE_URL = 'https://www.google.com/search'

  def initialize(keyword:)
    @uri = URI("#{BASE_URL}?q=#{CGI.escape(keyword)}")
    @user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/605.1.15 (KHTML, like Gecko) '\
                  'Version/11.1.2 Safari/605.1.15'
  end

  def call
    HTTParty.get(@uri, { headers: { 'User-Agent' => user_agent } })

    # TODO: Create a function that will look for google links and replace them with the image
  end

  private

  attr_reader :uri, :user_agent
end
