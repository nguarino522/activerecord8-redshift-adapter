# Changelog

## [1.0.0] - 2026-06-25

### Added
- Initial release of the AR 8.1-compatible fork.

### Changed
- `RedshiftColumn#initialize` accepts `cast_type` as second positional arg (AR 8.1).
- `clear_cache!` accepts `new_connection:` keyword arg (AR 8.1).
- `exec_insert` accepts and ignores `returning:` kwarg (AR 8.1; Redshift's `use_insert_returning?` is false).
- `PG::Coder` initialization uses `**hash` splat (pg 1.5+ deprecation).

### Compatibility
- ActiveRecord 8.1.x
- Ruby >= 3.2
- pg ~> 1.0