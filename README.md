activerecord8-redshift-adapter
==============================

Amazon Redshift adapter for ActiveRecord 8 (Rails 8).

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

Compatibility
-------------

- Ruby `>= 3.2`
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

To release a new version, bump `s.version` in the gemspec, tag the commit, then:

```bash
gem push activerecord8-redshift-adapter-<version>.gem
```

License
-------

MIT license (same as ActiveRecord).
