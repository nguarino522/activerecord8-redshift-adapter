# test/smoke_test.rb
require "active_record"
require "redshift_adapter"

ActiveRecord::Base.establish_connection(
  adapter:  "redshift",
  host:     ENV.fetch("REDSHIFT_HOST"),
  port:     ENV.fetch("REDSHIFT_PORT", 5439).to_i,
  database: ENV.fetch("REDSHIFT_DB"),
  username: ENV.fetch("REDSHIFT_USER"),
  password: ENV.fetch("REDSHIFT_PASS")
)

puts ActiveRecord::Base.connection.select_value("SELECT 1")
puts ActiveRecord::Base.connection.select_all("SELECT current_database()").to_a.inspect

class SomeRealTable < ActiveRecord::Base
  self.table_name = "<a real read-only table in your warehouse>"
end

puts SomeRealTable.columns.map { |c| [c.name, c.type] }.inspect
puts SomeRealTable.limit(3).to_a.inspect