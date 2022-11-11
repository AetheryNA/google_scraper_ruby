# frozen_string_literal: true

class Keyword < ApplicationRecord
  belongs_to :user, inverse_of: :keywords

  validates :keyword, presence: true

  enum status: { in_progress: 0, completed: 1, failed: 2 }
end
