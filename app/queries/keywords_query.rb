# frozen_string_literal: true

class KeywordsQuery
  def initialize(relation, filter_params)
    @relation = relation
    @filter = filter_params
  end

  attr_reader :relation, :filter

  def call
    return Keyword.none unless filter

    scope = exclude_html_column(relation)
    scope = filter_by_keywords(scope) if filter[:keyword].present?
    scope = filter_by_url(scope) if filter[:url].present?

    scope
  end

  def count_matching_urls
    return nil unless filter[:url]

    filtered_urls.count
  end

  def exclude_html_column(scope)
    scope.select(Keyword.column_names.excluding('html'))
  end

  def filter_by_keywords(scope)
    scope.where('keyword ~* ?', filter[:keyword])
  end

  def filter_by_url(scope)
    scope.where(links: filtered_urls)
  end

  def filtered_urls
    link = Link.where(keyword: relation)
    link = link.where('url ~* ?', filter[:url]) if filter[:url].present?

    link
  end
end
