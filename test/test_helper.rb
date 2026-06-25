# frozen_string_literal: true

require "minitest/autorun"
require "active_record"
require "redshift_adapter"

module TestConnection
  module_function

  def establish!
    ActiveRecord::Base.establish_connection(
      adapter:  "redshift",
      host:     ENV.fetch("PGHOST", "localhost"),
      port:     ENV.fetch("PGPORT", "5432").to_i,
      database: ENV.fetch("PGDATABASE", "redshift_adapter_test"),
      username: ENV.fetch("PGUSER", ENV["USER"]),
      password: ENV["PGPASSWORD"],
      variables: { client_min_messages: "warning" }
    )
  end
end