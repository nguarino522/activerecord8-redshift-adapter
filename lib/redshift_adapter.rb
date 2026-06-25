require "active_record"
require "active_record/connection_adapters/redshift_adapter"

module RedshiftAdapter
  def self.load
    ActiveRecord::ConnectionAdapters.register(
      "redshift",
      "ActiveRecord::ConnectionAdapters::RedshiftAdapter",
      "active_record/connection_adapters/redshift_adapter"
    )
  end

  if defined?(::Rails::Railtie)
    class Railtie < ::Rails::Railtie
      initializer "redshift_adapter.register" do
        RedshiftAdapter.load
      end
    end
  end
end

RedshiftAdapter.load
