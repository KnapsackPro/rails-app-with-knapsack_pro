require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "randomly failing" do
    assert [false, true].sample
  end
end
