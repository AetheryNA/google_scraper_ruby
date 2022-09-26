# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsForm, type: :form do
  describe '#save' do
    context 'given a valid file it' do
      it 'accepts a valid CSV' do
        form = save_file('valid.csv')
        expect(form.errors).to be_empty
      end
    end

    context 'given an invalid file, does not accept the file if it' do
      it 'has no file being uploaded' do
        form = save_file(nil)
        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_missing_file')
      end

      it 'has less than 1 word' do
        form = save_file('0_words.csv')
        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_invalid_size')
      end

      it 'has more than 1000 words' do
        form = save_file('1001_words.csv')
        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_invalid_size')
      end

      it 'does not have a CSV extension' do
        form = save_file('invalid_file_ext.txt')
        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_invalid_extention')
      end
    end
  end
end
