# frozen_string_literal: true

class KeywordsFormValidator < ActiveModel::Validator
  def validate(form)
    @form = form

    validate_file
  end

  attr_reader :form

  def validate_file
    if !keywords_file
      add_error('Invalid file, please upload a CSV file')
    elsif !evalid_extension
      add_error('Invalid extension, only CSV files are allowed')
    end
  end

  def add_error(message)
    form.errors.add(message)
  end

  def keywords_file
    form.file
  end

  def valid_extension
    keywords_file.content_type = 'text/csv'
  end
end
