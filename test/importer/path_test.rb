require_relative "../test_helper"

class PathTest < Minitest::Test
  def setup
    @subject = Importer::Path.new(filepath)
  end

  def filepath
    "test/fixtures/sample_path"
  end

  def test_it_can_be_initalized
    assert(@subject.class, Importer::Path)
  end

  def test_it_can_return_the_meta_for_a_sample_path
    assert_equal(@subject.attributes, {"id" => 118, "title"=>"The Ruby Way", "description"=>"I am a path"})
  end

  def test_it_can_return_a_json_resprentation_of_a_sample_path
    assert(@subject.to_json, {



    })
  end
end
