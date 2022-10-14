class KeywordsQuery
  def initialize(keywords, filters)
    @keywords = keywords
    @filters = filters
  end

  attr_reader :keywords, :filters

  def call
    @keywords = filtered_keywords if filter_by_keyword.present?
  end

  def filter_by_keyword
    filters[:keyword]
  end

  def filtered_keywords
    query = "%#{filter_by_keyword}"
    keywords.where('keyword ILIKE ?', query)
  end
end
