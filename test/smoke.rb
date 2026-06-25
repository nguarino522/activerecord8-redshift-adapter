# test/smoke.rb
#
# Ad-hoc smoke test against a real Redshift cluster.
# Not part of the rake task. Run with:
#
#   PGHOST=my-cluster.xxxxxx.us-east-1.redshift.amazonaws.com \
#   PGPORT=5439 PGDATABASE=analytics PGUSER=... PGPASSWORD=... \
#   bundle exec ruby test/smoke.rb

require "active_record"
require "redshift_adapter"

ActiveRecord::Base.establish_connection(
  adapter:  "redshift",
  host:     ENV.fetch("PGHOST"),
  port:     ENV.fetch("PGPORT", 5439).to_i,
  database: ENV.fetch("PGDATABASE"),
  username: ENV.fetch("PGUSER"),
  password: ENV.fetch("PGPASSWORD")
)

puts ActiveRecord::Base.connection.select_value("SELECT 1")
puts ActiveRecord::Base.connection.select_all("SELECT current_database()").to_a.inspect

class SomeRealTable < ActiveRecord::Base
  self.table_name = "<a real read-only table in your warehouse>"
end

puts SomeRealTable.columns.map { |c| [c.name, c.type] }.inspect
puts SomeRealTable.limit(3).to_a.inspect