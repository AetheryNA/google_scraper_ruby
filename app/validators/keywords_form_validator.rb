# frozen_string_literal: true

class KeywordsFormValidator < ActiveModel::Validator
  def validate(keywords_form)
    @keywords_form = keywords_form

    validate_file

    puts keywords_form.errors.full_messages
  end

  attr_reader :keywords_form

  def validate_file
    if !keywords_file
      add_error('Upload a file')
    elsif !valid_extension
      add_error('Only CSV files are accepted')
    end
  end

  def add_error(message)
    keywords_form.errors.add(:base, message)
  end

  def keywords_file
    keywords_form.file
  end

  def valid_extension
    keywords_file.content_type == 'text/csv'
  end
end
