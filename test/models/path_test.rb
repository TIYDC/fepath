require_relative '../test_helper'
module Models
  class PathTest
    def setup
      Path.new
    end

    def test_it_can_be_initalized
      assert(@subject.class, Path)
    end
  end
end
