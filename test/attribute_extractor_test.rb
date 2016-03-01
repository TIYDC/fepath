require 'test_helper'
require 'nokogiri'

class AttributeExtractorTest < Minitest::Test
  def setup
    page = Nokogiri::HTML(File.read(File.expand_path('test/fixtures/edit_assignment.html')))
    @attribute_extractor = AttributeExtractor.new(page, 'assignment')
  end

  def test_extract_will_return_attributes
    assert_equal(
      {
        'assignment' =>
        {
          'body' => "## GitHub\r\nInstructions - PB & J\r\n[link me up](https://tiy-learn-content.s3.amazonaws.com/ruby2.rb)\r\n[link me up](http://www.example.com/ruby.rb)",
          'title' => 'Accounts',
          'due_date' => '2016-02-29',
          'description' => 'Sign up for a GitHub, Heroku and Stackoverflow Accounts',
          'unit_id' => '454',
          "type"=>"assignment",
          "state"=>"public",
          'attachments' => [
            ['link me up', 'https://tiy-learn-content.s3.amazonaws.com/ruby2.rb']
          ]
        }
    }, @attribute_extractor.extract)
  end
end
