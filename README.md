activerecord-redshift-adapter
==============================

Amazon Redshift adapter for ActiveRecord 8 (Rails 8.1).
I forked the project from https://github.com/charitywater/activerecord-redshift-adapter

Thanks for the authors.

Usage
-------------------

For Rails 8, write following in Gemfile:

```ruby
gem 'activerecord-redshift-adapter', github: 'charitywater/activerecord-redshift-adapter'
```

In database.yml

```YAML
development:
  adapter: redshift
  host: host
  port: port
  database: db
  username: user
  password: password
  encoding: utf8
```

OR your can use in URL
```ruby
class SomeModel < ApplicationRecord
  establish_connection('redshift://username:password@host/database')
end
```

License
---------

MIT license (same as ActiveRecord)
