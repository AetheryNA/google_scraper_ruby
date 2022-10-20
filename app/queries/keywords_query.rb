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
  end

  def exclude_html_column(scope)
    scope.select(Keyword.column_names.excluding('html'))
  end

  def filter_by_keywords(scope)
    scope.where('keyword ILIKE ?', filter[:keyword])
  end
end
