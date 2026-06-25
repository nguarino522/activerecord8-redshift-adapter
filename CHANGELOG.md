# Changelog

## [1.0.0] - 2026-06-25

### Added
- Initial release of the AR 8.1-compatible fork.

### Changed
- `RedshiftColumn#initialize` accepts `cast_type` as second positional arg (AR 8.1).
- `clear_cache!` accepts `new_connection:` keyword arg (AR 8.1).
- `exec_insert` accepts and ignores `returning:` kwarg (AR 8.1; Redshift's `use_insert_returning?` is false).
- `PG::Coder` initialization uses `**hash` splat (pg 1.5+ deprecation).

### Fixed
- Adapter now reliably registers with ActiveRecord on Rails 8.1.
  Previously relied on a Rails autoload fallback that was removed in 8.1.
  - Add `lib/activerecord8-redshift-adapter.rb` so Bundler auto-require finds
    the gem's entry point on boot.
  - Add a Railtie so registration also runs during Rails initialization,
    covering apps that use `require: false`.

### Compatibility
- ActiveRecord 8.1.x
- Ruby >= 3.2
- pg ~> 1.0