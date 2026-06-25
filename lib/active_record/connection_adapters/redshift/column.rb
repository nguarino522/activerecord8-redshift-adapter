# frozen_string_literal: true

module ActiveRecord
  module ConnectionAdapters
    class RedshiftColumn < Column # :nodoc:
      delegate :oid, :fmod, to: :sql_type_metadata

      # Required for Rails 6.1, see https://github.com/rails/rails/pull/41756
      mattr_reader :array, default: false
      alias array? array

      def initialize(name, cast_type, default, sql_type_metadata = nil, null = true, default_function = nil, **)
        super
      end
    end
  end
end
