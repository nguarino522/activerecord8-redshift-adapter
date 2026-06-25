# frozen_string_literal: true

require "test_helper"

class WritePathTest < Minitest::Test
  TABLE = "rs_adapter_test_widgets"

  def setup
    TestConnection.establish!
    @conn = ActiveRecord::Base.connection
    @conn.execute("DROP TABLE IF EXISTS #{TABLE}")
    @conn.execute(<<~SQL)
      CREATE TABLE #{TABLE} (
        id    integer PRIMARY KEY,
        name  varchar(64) NOT NULL,
        qty   integer NOT NULL,
        price numeric(10,2)
      )
    SQL
  end

  def teardown
    @conn.execute("DROP TABLE IF EXISTS #{TABLE}") if @conn
    ActiveRecord::Base.connection_handler.clear_all_connections!
  end

  def model
    @model ||= Class.new(ActiveRecord::Base) { self.table_name = WritePathTest::TABLE }
  end

  def test_insert_via_model
    row = model.create!(id: 1, name: "alpha", qty: 5, price: 1.25)
    assert_equal 1, row.id
    assert_equal "alpha", model.find(1).name
  end

  def test_update_via_model
    model.create!(id: 2, name: "beta", qty: 10, price: 2.50)
    model.find(2).update!(qty: 99)
    assert_equal 99, model.find(2).qty
  end

  def test_delete_via_model
    model.create!(id: 3, name: "gamma", qty: 7, price: 3.00)
    model.find(3).destroy!
    assert_nil model.find_by(id: 3)
  end

  def test_count_and_sum
    model.create!(id: 4, name: "d", qty: 1, price: 1)
    model.create!(id: 5, name: "e", qty: 2, price: 2)
    model.create!(id: 6, name: "f", qty: 3, price: 3)
    assert_equal 3, model.count
    assert_equal 6, model.sum(:qty)
  end

  def test_maximum_minimum_average
    model.create!(id: 7, name: "g", qty: 10, price: 1)
    model.create!(id: 8, name: "h", qty: 20, price: 2)
    model.create!(id: 9, name: "i", qty: 30, price: 3)
    assert_equal 30, model.maximum(:qty)
    assert_equal 10, model.minimum(:qty)
    assert_equal 20, model.average(:qty).to_i
  end
end