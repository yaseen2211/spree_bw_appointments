source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'spree', github: 'spree/spree', branch: 'master'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: 'master'
gem 'rails-controller-testing'

gem 'rubocop', require: false
gem 'rubocop-rspec', require: false
gem 'spree_multi_vendor', github: 'spree-contrib/spree_multi_vendor'
gem 'bootstrap-daterangepicker-rails'
gem 'jbuilder', '~> 2.0'

group :development do
  gem 'spree_scaffold', github: 'yaseen2211/spree_scaffold', branch: 'master'
end
gem 'google-api-client', require: 'google/apis/calendar_v3'

gemspec



