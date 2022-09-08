# frozen_string_literal: true

describe 'Printing', testFile: true do
  it 'Prints hello world' do
    def hello_world
      puts 'Hello World'
    end

    expect(hello_world).to equal(nil)
  end
end
