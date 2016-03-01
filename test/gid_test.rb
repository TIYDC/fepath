require 'test_helper'

class GidTest < Minitest::Test
  def setup
    @gid = Gid.new('gid://learn/Assignment/830')
  end

  def test_path_is_a_rails_show_path
    assert_equal 'assignments/830', @gid.path
  end

  def test_path_is_a_rails_edit_path
    assert_equal 'assignments/830/edit', @gid.path(action: 'edit')
  end

  def test_klass_is_last_value
    assert_equal 'Assignment', @gid.klass
  end

  def test_id_is_last_value
    assert_equal '830', @gid.id
  end
end
