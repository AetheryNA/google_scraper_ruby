# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/keywords').to route_to('keywords#index')
    end

    it 'routes to #create' do
      expect(post: '/keywords').to route_to('keywords#create')
    end
  end
end
