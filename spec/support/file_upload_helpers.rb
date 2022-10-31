# frozen_string_literal: true

module FileUploadHelpers
  module File
    def save_file(file_path)
      if file_path
        file = file_fixture(file_path)
        file_content_type = Rack::Mime::MIME_TYPES[file.extname]
        file = Rack::Test::UploadedFile.new(file, file_content_type)
      else
        file = nil
      end
      form = KeywordsForm.new(Fabricate(:user))
      form.save(file)
      form
    end
  end

  module Request
    def keywords_file_params(file_name)
      path = Rails.root.join('spec', 'fixtures', 'files', file_name)

      { keywords_file: Rack::Test::UploadedFile.new(path, 'text/csv', true) }
    end
  end
end

RSpec.configure do |config|
  config.include FileUploadHelpers::File, type: :form
end
