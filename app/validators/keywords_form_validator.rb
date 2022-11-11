# frozen_string_literal: true

class KeywordsFormValidator < ActiveModel::Validator
  attr_reader :keywords_form

  def validate(keywords_form)
    keywords_file = keywords_form.file

    return keywords_form.errors.add(:base, I18n.t('csv.upload_fail_missing_file')) if keywords_file.blank?

    unless keywords_file.content_type == 'text/csv'
      return keywords_form.errors.add(:base,
                                      I18n.t('csv.upload_fail_invalid_extention'))
    end
    unless CSV.read(keywords_file.path).count.between?(
      1, 1000
    )
      keywords_form.errors.add(:base,
                               I18n.t('csv.upload_fail_invalid_size'))
    end
  end
end
