require "test_helper"
require "nokogiri"

class ContainerConverterTest < Minitest::Test
  def setup
    FileUtils.rmdir(test_path)
    @item = JSON.parse(File.read(File.expand_path("test/fixtures/assignment.json")))
  end

  def test_path
    "tmp/test"
  end

  def test_can_convert_an_item
    ContainerConverter.new(dest: test_path, container: @item, index: 1).convert
    assert Dir.exists?(File.join(test_path, "2_css_reverse_engineering"))
  end
end
