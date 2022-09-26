# frozen_string_literal: true

class KeywordsFormValidator < ActiveModel::Validator
  def validate(keywords_form)
    @keywords_form = keywords_form

    validate_file

    Rails.logger.debug keywords_form.errors.full_messages
  end

  attr_reader :keywords_form

  def validate_file
    if !keywords_file
      add_error(I18n.t('csv.upload_fail_missing_file'))
    elsif !valid_extension
      add_error(I18n.t('csv.upload_fail_invalid_extention'))
    elsif !size_valid
      add_error(I18n.t('csv.upload_fail_invalid_size'))
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

  def size_valid
    CSV.read(keywords_file.path).count.between?(1, 1000)
  end
end
