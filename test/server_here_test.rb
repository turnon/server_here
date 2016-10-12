require 'test_helper'

class ServerHereTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ServerHere::VERSION
  end

end
