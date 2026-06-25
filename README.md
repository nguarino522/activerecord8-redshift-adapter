activerecord8-redshift-adapter
==============================

[![Test](https://github.com/nguarino522/activerecord8-redshift-adapter/actions/workflows/test.yml/badge.svg)](https://github.com/nguarino522/activerecord8-redshift-adapter/actions/workflows/test.yml)
[![Gem Version](https://badge.fury.io/rb/activerecord8-redshift-adapter.svg)](https://rubygems.org/gems/activerecord8-redshift-adapter)
[![License](https://img.shields.io/badge/license-MIT%20%26%20BSD--3--Clause-blue)](LICENSE)

Amazon Redshift adapter for ActiveRecord 8.1 (Rails 8.1).

Forked from [charitywater/activerecord-redshift-adapter](https://github.com/charitywater/activerecord-redshift-adapter) (which itself descends from the original [fiksu/activerecord-redshift-adapter](https://github.com/fiksu/activerecord-redshift-adapter)). The prior forks targeted Rails 8.0; this gem updates the adapter to work with the changes introduced in ActiveRecord 8.1. Thanks to all the prior authors.

Installation
------------

Add to your Gemfile:

```ruby
gem 'activerecord8-redshift-adapter', '~> 1.0'
```

Then:

```bash
bundle install
```

Or install it directly:

```bash
gem install activerecord8-redshift-adapter
```

Usage
-----

In `config/database.yml`:

```yaml
development:
  adapter: redshift
  host: host
  port: port
  database: db
  username: user
  password: password
  encoding: utf8
```

Or via a connection URL:

```ruby
class SomeModel < ApplicationRecord
  establish_connection('redshift://username:password@host/database')
end
```

### Typical pattern: Redshift as a secondary read-only connection

Most apps use Redshift alongside a primary OLTP database (Postgres, MySQL). With ActiveRecord multi-database support:

```yaml
production:
  primary:
    adapter: postgresql
    database: app_production
    # ...
  warehouse:
    adapter: redshift
    host: my-cluster.xxxxxx.us-east-1.redshift.amazonaws.com
    port: 5439
    database: analytics
    username: app_reader
    password: <%= ENV["REDSHIFT_PASSWORD"] %>
    replica: true
```

```ruby
class AnalyticsRecord < ApplicationRecord
  self.abstract_class = true
  connects_to database: { reading: :warehouse }
end

class PageView < AnalyticsRecord
  self.table_name = "page_views"
end
```

Compatibility
-------------

- Ruby `>= 3.2` (tested on 3.2, 3.3, 3.4)
- ActiveRecord `>= 8.1, < 9.0` (Rails 8.1)
- `pg` `~> 1.0`

For older Rails versions, use the matching gem in the same family:
[`activerecord7-redshift-adapter`](https://rubygems.org/gems/activerecord7-redshift-adapter),
[`activerecord6-redshift-adapter`](https://rubygems.org/gems/activerecord6-redshift-adapter),
[`activerecord5-redshift-adapter`](https://rubygems.org/gems/activerecord5-redshift-adapter).
For Rails 8.0, the upstream [`activerecord-redshift-adapter`](https://rubygems.org/gems/activerecord-redshift-adapter) `8.0.x` still works.

Development
-----------

```bash
bundle install
gem build activerecord8-redshift-adapter.gemspec
```

To release a new version (maintainers), bump `s.version` in the gemspec, tag the commit, then:

```bash
gem push activerecord8-redshift-adapter-<version>.gem
```

Testing
-------

The test suite runs against a local **PostgreSQL** database (Redshift is wire-compatible with Postgres 8.0, so most adapter behavior can be exercised locally). For Redshift-specific behavior — `RETURNING`, identity columns, distribution keys, system catalogs — run the smoke script against a real cluster (see below).

### Prerequisites

- PostgreSQL running locally (any reasonably modern version)
- A database the test user can connect to and create tables in

```bash
createdb redshift_adapter_test
```

### Running the suite

```bash
bundle install
bundle exec rake test
```

Connection settings come from standard `PG*` environment variables, with sensible defaults:

| Variable     | Default                 |
| ------------ | ----------------------- |
| `PGHOST`     | `localhost`             |
| `PGPORT`     | `5432`                  |
| `PGDATABASE` | `redshift_adapter_test` |
| `PGUSER`     | `$USER`                 |
| `PGPASSWORD` | _(unset)_               |

Override any of them inline, e.g.:

```bash
PGUSER=postgres PGPASSWORD=secret bundle exec rake test
```

### Smoke-testing against real Redshift

`test/smoke.rb` is a small ad-hoc script (not part of the rake task) that connects to a real Redshift cluster using the same env vars and exercises basic queries. Use it to validate the adapter against your actual cluster before deploying:

```bash
PGHOST=my-cluster.xxxxxx.us-east-1.redshift.amazonaws.com \
PGPORT=5439 \
PGDATABASE=analytics \
PGUSER=myuser \
PGPASSWORD=... \
bundle exec ruby test/smoke.rb
```

License
-------

Dual-licensed under MIT (Rails-derived code) and BSD-3-Clause (Fiksu Redshift-specific portions). See [`LICENSE`](LICENSE) for full text.
