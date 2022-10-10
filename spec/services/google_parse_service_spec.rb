# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GoogleParseService, type: :service do
  describe '#call' do
    context 'when parsing a result ends with 86 total links, 9 non ad links and 6 ads' do
      it 'counts 3 top ad link' do
        VCR.use_cassette('services/google_parse_service', record: :once) do
          html_response = GoogleSearchService.new(keyword: 'car rental').call

          expect(described_class.new(html: html_response).ads_top_count).to eq(3)
        end
      end

      it 'counts 3 ads links on page' do
        VCR.use_cassette('services/google_parse_service', record: :once) do
          html_response = GoogleSearchService.new(keyword: 'car rental').call

          expect(described_class.new(html: html_response).ads_page_count).to eq(3)
        end
      end

      it 'counts 9 non ad links' do
        VCR.use_cassette('services/google_parse_service', record: :once) do
          html_response = GoogleSearchService.new(keyword: 'car rental').call

          expect(described_class.new(html: html_response).non_ads_count).to eq(9)
        end
      end

      it 'counts 35 total links on page' do
        VCR.use_cassette('services/google_parse_service', record: :once) do
          html_response = GoogleSearchService.new(keyword: 'car rental').call

          expect(described_class.new(html: html_response).total_links_count).to eq(86)
        end
      end
    end
  end
end
