Gem::Specification.new do |s|
  s.platform = Gem::Platform::RUBY
  s.name = 'activerecord8-redshift-adapter'
  s.version = '1.0.0'
  s.summary = 'Amazon Redshift adapter for ActiveRecord 8 (Rails 8.1)'
  s.description = 'Amazon Redshift adapter for ActiveRecord 8.x, updated for Rails 8.1 compatibility.'
  s.license = 'MIT'

  s.author = [
    'Nicholas Guarino',
    'Nancy Foen',
    'Minero Aoki',
    'iamdbc',
    'Quentin Rousseau',
    'Johan Le Bray',
    "Tristan O'Neil"
  ]
  s.email = 'nguarino05@gmail.com'
  s.homepage = 'https://github.com/nguarino522/activerecord8-redshift-adapter'

  s.files = Dir.glob(['LICENSE', 'README.md', 'lib/**/*.rb'])
  s.require_path = 'lib'

  s.metadata = {
    'source_code_uri'   => s.homepage,
    'bug_tracker_uri'   => "#{s.homepage}/issues",
    'changelog_uri'     => "#{s.homepage}/blob/main/CHANGELOG.md",
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = '>= 3.2'
  s.add_runtime_dependency 'activerecord', '>= 8.1', '< 9.0'
  s.add_runtime_dependency 'pg', '~> 1.0'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'minitest', '~> 5.0'
end
