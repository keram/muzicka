source 'https://rubygems.org'

#gem 'rails', :path => 'vendor/rails/'
gem 'rails', '~> 3.2.8'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'rack-ssl', :require => 'rack/ssl'
gem 'rack-rewrite'
gem 'pg'

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'webmock'
  gem 'refinerycms-testing'
  gem 'poltergeist'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

# Refinery CMS
# gem 'refinerycms', '~> 2.0.3' #, :path => 'vendor/refinerycms', :branch => '2-0-stable'
#gem 'refinerycms', :path => 'vendor/refinerycms', :branch => 'master'
gem 'refinerycms', :git => 'git://github.com/refinery/refinerycms.git', :branch => 'master'
gem 'refinerycms-settings', :git => 'git://github.com/refinery/refinerycms-settings.git', :branch => 'master'

# Specify additional Refinery CMS Extensions here (all optional):
# gem 'refinerycms-i18n', '~> 2.0.0'
gem 'refinerycms-i18n', :git => 'git://github.com/refinery/refinerycms-i18n.git', :branch => 'master'
gem 'refinerycms-blog', :git => 'git://github.com/refinery/refinerycms-blog.git', :branch => 'master'
gem 'refinerycms-inquiries', :git => 'git://github.com/refinery/refinerycms-inquiries.git', :branch => 'master'
