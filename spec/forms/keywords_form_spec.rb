# frozen_string_literal: true

require 'rails_helper'

RSpec.describe KeywordsForm, type: :form do
  describe '#save' do
    context 'given a valid file' do
      it 'does NOT add an error' do
        form = save_file(file: 'valid.csv')
        expect(form.errors).to be_empty
      end
    end

    context 'given NO file' do
      it 'has no file being uploaded' do
        file = nil
        form = described_class.new(Fabricate(:user))
        form.save(file: file)

        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_missing_file')
      end
    end

    context 'given file is empty' do
      it 'adds an invalid size error' do
        form = save_file(file: '0_words.csv')

        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_invalid_size')
      end
    end

    context 'given file has more than 1000 words' do
      it 'adds an invalid size error' do
        form = save_file(file: '1001_words.csv')

        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_invalid_size')
      end
    end

    context 'given file does NOT have a CSV extension' do
      it 'adds an invalid extension error' do
        form = save_file(file: 'invalid_file_ext.txt')

        expect(form.errors.full_messages.first).to eq I18n.t('csv.upload_fail_invalid_extention')
      end
    end
  end
end
