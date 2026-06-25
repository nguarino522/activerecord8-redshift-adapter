# frozen_string_literal: true

require "test_helper"

class ReadPathTest < Minitest::Test
  TABLE = "rs_adapter_test_widgets"

  def setup
    TestConnection.establish!
    @conn = ActiveRecord::Base.connection
    @conn.execute("DROP TABLE IF EXISTS #{TABLE}")
    @conn.execute(<<~SQL)
      CREATE TABLE #{TABLE} (
        id       integer PRIMARY KEY,
        name     varchar(64) NOT NULL,
        qty      integer NOT NULL,
        price    numeric(10,2),
        active   boolean DEFAULT true,
        created_at timestamp
      )
    SQL
    @conn.execute(<<~SQL)
      INSERT INTO #{TABLE} (id, name, qty, price, active, created_at) VALUES
        (1, 'alpha', 10, 1.50, true,  '2026-01-01 00:00:00'),
        (2, 'beta',  20, 2.75, false, '2026-01-02 00:00:00'),
        (3, 'gamma', 30, 3.00, true,  '2026-01-03 00:00:00')
    SQL
  end

  def teardown
    @conn.execute("DROP TABLE IF EXISTS #{TABLE}") if @conn
    ActiveRecord::Base.connection_handler.clear_all_connections!
  end

  def model
    @model ||= Class.new(ActiveRecord::Base) { self.table_name = ReadPathTest::TABLE }
  end

  def test_columns_returns_metadata
    cols = @conn.columns(TABLE).map(&:name).sort
    assert_equal %w[active created_at id name price qty], cols
  end

  def test_select_all_returns_rows
    result = @conn.select_all("SELECT id, name, qty FROM #{TABLE} ORDER BY id")
    assert_equal 3, result.length
    assert_equal "alpha", result.first["name"]
    assert_equal 10, result.first["qty"].to_i
  end

  def test_model_find_returns_typed_attributes
    row = model.find(1)
    assert_equal "alpha", row.name
    assert_equal 10, row.qty
    assert_equal BigDecimal("1.50"), row.price
    assert_equal true, row.active
  end

  def test_model_where_pluck
    qtys = model.where(active: true).order(:id).pluck(:qty)
    assert_equal [10, 30], qtys
  end
end