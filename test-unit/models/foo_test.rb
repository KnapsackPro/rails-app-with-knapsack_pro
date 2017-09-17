require 'test_helper'

class FooTest < Test::Unit::TestCase
  class << self
    def startup
      puts 'STARTUP --------'
    end

    def shutdown
      puts 'SHUTDOWN --------'
    end
  end

  test "the truth" do
    assert true
  end

  test "yet another truth" do
    assert true
  end
end
