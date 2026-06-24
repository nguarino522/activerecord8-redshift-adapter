# frozen_string_literal: true

require "test_helper"

class ConnectionTest < Minitest::Test
  def setup
    TestConnection.establish!
    @conn = ActiveRecord::Base.connection
  end

  def teardown
    ActiveRecord::Base.connection_handler.clear_all_connections!
  end

  def test_select_one
    assert_equal 1, @conn.select_value("SELECT 1").to_i
  end
end